import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Storage/user_storage_service.dart';
import '../network/services/ReelsAPI.dart';
import 'ReelShareState.dart';

class ReelShareCubit extends Cubit<ReelShareState> {
  ReelShareCubit() : super(InitialShareState());

  final api = ReelsAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));


  Future<void> sendReelLike(String postId) async {
    try {
      final res = await api.sendReelLike('Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "reaction": "like"});
      if (res.response.statusCode == 200) {
        print("reel like api working");
      } else {
        print("not api");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }

  Future<void> shareReelToAll(String postId) async {
    try {
      final res = await api.shareReel('Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "is_whatsapp": false});
      if (res.response.statusCode == 200) {
        emit(ReelSharedToAll());
        print("share to all reel api working");
      } else {
        print("not api");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }

  Future<void> shareReelToWhatsapp(String postId) async {
    try {
      final res = await api.shareReel('Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "is_whatsapp": true});
      if (res.response.statusCode == 200) {
        emit(ReelSharedToWhatsapp());
        print("whatsapp sharing working");
      } else {
        print("not api");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }
}
