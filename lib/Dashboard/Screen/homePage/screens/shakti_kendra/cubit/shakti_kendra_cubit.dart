import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/model/delete_model.dart';

import '../../../../../../Storage/user_storage_service.dart';
import '../network/api/vidhanSabha_api.dart';
import '../network/model/shakti_kendr_model.dart';
import '../network/model/vidhanSabha_model.dart';
import '../screen/model/booth_selection_model.dart';
import '../screen/widgets/delete_confirmation_dialog.dart';

part 'shakti_kendra_state.dart';

VidhanSabha vidhanSabha = VidhanSabha();

class ShaktiKendraCubit extends Cubit<ShaktiKendraState> {
  ShaktiKendraCubit() : super(ShaktiKendraInitial());

  Locations? zilaSelected;
  String zilaSelectedName = '';
  int isSelectedIndex = -1;
  bool isExpanded = false;
  bool isEditPermission = false;
  bool isCreatePermission = false;
  bool isDeletePermission = false;
  List<String> filterList = ["नवीन एंट्री", "मंडल", "A - Z"];
  ShaktiKendr shaktiKendr = ShaktiKendr();
  ShaktiKendr sortedShaktiKendr = ShaktiKendr();
  List<Mandal> mandalFilterData = [];
  String selectedMandal = "All";

  final api = GetDropDownValue(Dio(BaseOptions(contentType: 'application/json', validateStatus: ((status) => true))));

  emitState() {
    emit((LoadingShaktiKendraState()));
  }

  Future getDropDownValueOfVidhanSabha({required int id, required String locationType}) async {
    try {
      emit(LoadingShaktiKendraState());
      StorageService.getUserAuthToken();
      var res = await api.getVidhanSabhaValue('Bearer ${StorageService.userAuthToken}', id, locationType);
      print("------------------------------------ SK VidhanSabha DropDown Value  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("url: ${res.response.realUri} ");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        VidhanSabha data = VidhanSabha.fromJson(res.response.data);
        emit(FatchDataVidhanSabhaState(data));
      } else {
        emit(ErrorVidhanSabhaState(error: 'someting went wrong'));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ErrorVidhanSabhaState(error: e.toString()));
      print('error=$e');
    }
  }

  getShaktiKendra({required int id}) async {
    try {
      emit(LoadingShaktiKendraDetailState());
      StorageService.getUserAuthToken();
      var res = await api.getShaktiKenr('Bearer ${StorageService.userAuthToken}', id);
      print("------------------------------------ Shakti Kendra Value  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("id  :$id");
      print(res.response.realUri);
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        ShaktiKendr data = ShaktiKendr.fromJson(res.response.data);
        emit(ShaktiKendraFatchData(data));
      } else {
        emit(ShaktiKendraErrorState(res.data['message']));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(ShaktiKendraErrorState('Something Went Wrong'));
      print('error=$e');
    }
  }

  deleteShaktiKendr({required int id, required BuildContext context, bool? isConfirmDelete}) async {
    try {
      emit(DeleteDataShaktiKendraLoadingState());
      StorageService.getUserAuthToken();
      var res = await api.deleteShaktiKendr('Bearer ${StorageService.userAuthToken}', id, isConfirmDelete!);
      print("------------------------------------ Delete Shakti Kendra Value  ----------------------------");
      print("token  :${StorageService.userAuthToken}");
      print("id  :$id");
      print("Status code : ${res.response.statusCode}");
      print("Response :${res.data}");
      print("------------------------------------ ------------------------ ----------------------------");
      if (res.response.statusCode == 200) {
        DeleteModel data = DeleteModel.fromJson(res.response.data);
        if (data.data?.askConfirmation == true) {
          await dataEntryDeleteDialog(
            context: context,
            onDelete: () {
              Navigator.pop(context);
              deleteShaktiKendr(id: id, context: context, isConfirmDelete: true);
            },
            title: data.data?.message?.trim().trimLeft(),
            subTitle: '',
          );
        }
        emit(DeleteShaktiKendraFatchDataState(data));
        // if (data.data?.askConfirmation == true) {
        //   dataEntryDeleteDialog(
        //     context: context,
        //     onDelete: () {
        //       Navigator.pop(context);
        //       deleteShaktiKendr(
        //           id: id, context: context, isConfirmDelete: true);
        //     },
        //     title: data.data?.message?.trim().trimLeft(),
        //     subTitle: '',
        //   );
        //   getShaktiKendra(id: zilaSelected?.id ?? 357);
        // } else {
        //   EasyLoading.showSuccess(data.data?.message ?? '');
        //   getShaktiKendra(id: zilaSelected?.id ?? 357);
        // }
      } else {
        emit(DeleteShaktiKendraErrorState(res.data['message']));
        print('error=${res.data['message']}');
      }
    } catch (e) {
      emit(DeleteShaktiKendraErrorState('Something Went Wrong'));
    }
  }

  getBoothId(List<Booth>? booths) {}

  changeFilter() {
    sortedShaktiKendr.data = [...shaktiKendr.data ?? []];
    if (isSelectedIndex == 0) {
      sortedShaktiKendr.data?.sort(
        (a, b) {
          DateTime aDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(a.createdAt ?? "");
          DateTime bDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(b.createdAt ?? "");
          return bDate.compareTo(aDate);
        },
      );
    } else if (isSelectedIndex == 1) {
      filterBasedOnMandal();
    } else if (isSelectedIndex == 2) {
      sortedShaktiKendr.data?.sort((a, b) {
        return (a.name?.toLowerCase() ?? 'z').compareTo((b.name?.toLowerCase()) ?? 'z');
      });
    }
    emit(LoadingShaktiKendraState());
    // emit(FilterChangeState());
  }

  filterBasedOnMandal() {
    List<ShaktiKendrData> demoData = [];
    emit(ApplyFilterLoading());
    if (selectedMandal == "All") {
      sortedShaktiKendr.data = [...shaktiKendr.data ?? []];
    } else {
      for (int i = 0; i < (shaktiKendr.data?.length ?? 0); i++) {
        if (shaktiKendr.data?[i].mandal?.name == selectedMandal) {
          demoData.add(shaktiKendr.data![i]);
        }
      }
      sortedShaktiKendr.data = demoData;
    }
    emit(ApplyFilterSuccess());
  }
}
