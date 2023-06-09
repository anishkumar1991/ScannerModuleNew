import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sangathan/Login/Cubit/login_state.dart';
import 'package:sangathan/Login/Network/api/auth_api.dart';
import 'package:sangathan/Login/Network/model/login_model.dart';
import 'package:sangathan/Login/Network/model/user_model.dart';

import '../../Storage/user_storage_service.dart';
import '../Network/model/onboarding_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static GetStorage storage = GetStorage();

  final api = AuthApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  int count = 60;

  Timer? timer;
  final focusNode = FocusNode();

  Future<void> startTimer() async {
    emit(LoadingState());
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (count != 0) {
        emit(LoadingState());
        emit(TimerRunningState(count--));
      } else {
        timer?.cancel();
        emit(TimerStopState());
      }
    });
  }

  Future loginUser({required String mobileNumber}) async {
    try {
      emit(LoginLoadingState());
      final res = await api.loginUser({'phone_number': mobileNumber});
      print(res.data['identification_token']);
      print(
          "------------------------------------ Login  ----------------------------");

      print("Status code : ${res.response.statusCode}");
      print("url : ${res.response.realUri}");
      log("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(res.data);
        await StorageService.setUserIdentificationToken(
            model.identificationToken ?? '');
        emit(UserLoggedState(model));
      } else {
        //   LoginModel? model = LoginModel.fromJson(res.data);
        emit(LoginFaieldState(res.data["message"] ?? ''));
      }
    } on Exception catch (e) {
      LoginFaieldState(e.toString());
    }
  }

  Future resendOTP() async {
    try {
      emit(LoadingState());
      String token = StorageService.getUserIdentificationToken() ?? '';
      final res = await api.resendOtp({'identification_token': token});

      print(
          "------------------------------------ Login  ----------------------------");

      print("Status code : ${res.response.statusCode}");
      print("url : ${res.response.realUri}");
      log("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(res.data);
        emit(OtpResendSuccessfullyState(model));
      } else {
        LoginModel? model = LoginModel.fromJson(res.data);
        emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      LoginFaieldState(e.toString());
    }
  }

  Future submitOTP({required String otp}) async {
    try {
      emit(SubmitOtpLoadingState());
      String token = StorageService.getUserIdentificationToken() ?? '';
      final res = await api.submitOtp(
        {'identification_token': token, 'otp': otp},
        'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D)',
      );
      print(
          "------------------------------------ Submit otp get user data  ----------------------------");
      print("otp  :$otp");
      print("Status code : ${res.response.statusCode}");
      print("url : ${res.response.realUri}");
      log("Response :${res.data}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        UserDetails userData = UserDetails.fromJson(res.data);
        setSupportNumber(
            supportNumber: userData.helplines?.first.phoneNumber ?? '');
        print('Auth token==${userData.authToken}');
        await StorageService.setUserData(userData);
        StorageService.getUserData();
        await StorageService.setUserAuthToken(userData.authToken ?? '');
        emit(UserLoginSuccessfullyState(userData));
      } else {
        Map<String, dynamic>? msg = res.data;
        print('msg-=$msg');
        emit(LoginFaieldState(msg?['message'] ?? ''));
      }
    } on Exception catch (e) {
      emit(LoginFaieldState("Something want to wrong!"));
      print('catch $e');
    }
  }

  static setSupportNumber({required String supportNumber}) async {
    await storage.write('supportNumber', supportNumber);
  }

  Future logOut() async {
    try {
      emit(LogOutLoadingState());
      String token = StorageService.getUserAuthToken() ?? '';
      final respose = await api.logOut('Bearer $token');
      print('logOut=${respose.response.statusCode}');
      if (respose.response.statusCode == 200) {
        Map<String, dynamic> msg = respose.data;
        /* await StorageService.removeUserAuthToken();
        await StorageService.removeUserIdentificationToken();*/
        StorageService.cleanAllLocalStorage();
        emit(UserLogOutSuccessState(msg['message']));
      } else {
        emit(UserLogOutFaieldState('Something Went Wrong'));
      }
    } catch (e) {
      UserLogOutFaieldState('Something Went Wrong');
    }
  }

  /// User onboarding

  Future getProgramLevel(Map<String, dynamic> data) async {
    emit(UserOnboardingLoadingState());
    try {
      String token = StorageService.getUserAuthToken() ?? "";
      final res = await api.userOnboarding(token, data);
      print(
          "------------------------------------  User onboarding  ----------------------------");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("url : ${res.response.realUri}");
      print("Pass Data:${res.response.extra}");
      print(
          "------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        OnboardingModel data = OnboardingModel.fromJson(res.data);
        emit(UserOnboardingSuccessState(data));
      } else {
        print('error=${res.data}');
        emit(UserOnboardingErrorState());
      }
    } catch (e) {
      print(e);
      emit(UserOnboardingErrorState());
    }
  }
}
