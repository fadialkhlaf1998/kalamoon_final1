

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../services/api.dart';
import '../services/app_style.dart';
import '../services/user_info.dart';
import '../controller/intro_conroller.dart';
import '../controller/login_controller.dart';
import '../app_localization.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class HomeController extends GetxController{

  LoginController loginController = Get.find();
  IntroController introController = Get.find();

  RxInt selectDay = 0.obs;
  RxInt selectDayId = 1.obs;  //introController.weekDayList.first.id.obs;
  ItemScrollController itemScrollController = ItemScrollController();
  RxBool editMode = false.obs;
  RxInt selectIndexForEndHour = (-1).obs;
  RxInt selectIndexForBeginHour = (-1).obs;
  RxInt selectIndexForStation = (-1).obs;

  RxBool cancelBeginHour = false.obs;
  RxBool cancelEndHour = false.obs;

  RxString newBeginHourValue = ''.obs;
  RxString newEndHourValue = ''.obs;
  RxString newStationValue = ''.obs;

  String? beginHourDataToSave;
  String? endHourDataToSave;
  String? stationDataToSave;

  RxBool loading = false.obs;


  @override
  void onInit() {
    super.onInit();
  } // Future scrollToItem(index) async{
  //   itemScrollController.scrollTo(
  //       index: index,
  //       alignment: index == 0 ? 0 : index == daysList.length - 1 ? 0.5 : 0.4,
  //       curve: Curves.fastOutSlowIn,
  //       duration: const Duration(milliseconds: 1000)
  //   );
  // }

  goToSelectMode(context,String translation,String tag,List<dynamic> dataList){
    if(editMode.value){
      Get.toNamed('/selectionMenu',arguments: [App_Localization.of(context).translate(translation), tag, dataList]);
    }else{
      editMode.value = true;
    }
  }

  saveCurrentOrNewMeet(context) async {
    if(newBeginHourValue.value == ''
        && newEndHourValue.value == ''
        && newStationValue.value == ''){
      editMode.value = false;
    }else{

      if(loginController.studentDay[selectDay.value].meet.isEmpty){
        if(newBeginHourValue.value == ''){
          beginHourDataToSave = null;
        }else{
          if(cancelBeginHour.value){
            beginHourDataToSave = null;
          }else{
            beginHourDataToSave = introController.beginHourList[selectIndexForBeginHour.value].id.toString();
          }
        }

        if(newEndHourValue.value == ''){
          endHourDataToSave = null;
        }else{
          if(cancelEndHour.value){
            endHourDataToSave = null;
          }else{
            endHourDataToSave = introController.endHourList[selectIndexForEndHour.value].id.toString();
          }
        }

        if(newStationValue.value == ''){
          stationDataToSave = null;
        }else{
          stationDataToSave = introController.stationsList[selectIndexForStation.value].id.toString();
        }

        if(newBeginHourValue.isNotEmpty && newStationValue.isEmpty){
          Get.snackbar(
              App_Localization.of(context).translate('warning'),
              App_Localization.of(context).translate('you_should_choose_station'),
              margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
              backgroundColor: AppStyle.red,
              icon: const Icon(Icons.warning)
          );
        }else if(beginHourDataToSave == null && endHourDataToSave == null){
          editMode.value = false;
          resetValue();
        }else{
          loading.value = true;
          Api.addMeet(beginHourDataToSave, endHourDataToSave, stationDataToSave, selectDayId.toString() , UserInfo.id).then((value){
            if(value){
              editMode.value = false;
            }else{
              print('error');
              loading.value = false;
            }
          });
          Future.delayed(const Duration(milliseconds: 500)).then((value) async {
            await Api.login(UserInfo.studentId, UserInfo.password).then((value) async{
              if(value.id != -1) {
                print('------------------');
                loginController.studentDay.clear();
                loginController.studentDay.addAll(value.days);
                print(loginController.studentDay[selectDay.value].meet.length);
                resetValue();
                loading.value = false;
              }else{
                print('error login');
                loading.value = false;
              }
            });
          });
        }


        print('========================');
        print(beginHourDataToSave);
        print(endHourDataToSave);
        print(stationDataToSave);
        print('========================');

      }else{

        if(newBeginHourValue.value == ''){
          if(loginController.studentDay[selectDay.value].meet.first.beginId == -1){
            beginHourDataToSave = null;
          }else{
            beginHourDataToSave = loginController.studentDay[selectDay.value].meet.first.beginId.toString();
          }
        }else{
          if(cancelBeginHour.value){
            beginHourDataToSave = null;
          }else{
            beginHourDataToSave = introController.beginHourList[introController.beginHourList.indexWhere((h)=> h.hour == newBeginHourValue.value)].id.toString();
          }
        }

        if(newEndHourValue.value == ''){
          if(loginController.studentDay[selectDay.value].meet.first.endHour == ''){
            endHourDataToSave = null;
          }else{
            endHourDataToSave = loginController.studentDay[selectDay.value].meet.first.endId.toString();//introController.endHourList[introController.endHourList.indexWhere((h)=> h.hour == loginController.studentDay[selectDay.value].meet.first["end_hour"])].id.toString();
          }
        }else{
          if(cancelEndHour.value){
            endHourDataToSave = null;
          }else{
            endHourDataToSave = introController.endHourList[introController.endHourList.indexWhere((h)=> h.hour == newEndHourValue.value)].id.toString();
          }
        }

        if(newStationValue.value == ''){
          if(loginController.studentDay[selectDay.value].meet.first.station == []){
            stationDataToSave = null;
          }else{
            stationDataToSave = loginController.studentDay[selectDay.value].meet.first.stationId.toString();
          }
        }else{
          stationDataToSave = introController.stationsList[selectIndexForStation.value].id.toString();
        }

        print('========================');
        print(beginHourDataToSave);
        print(endHourDataToSave);
        print(stationDataToSave);
        print('========================');
        loading.value = true;
        // if(beginHourDataToSave == null){
        //   stationDataToSave = null;
        // }
        Api.editMeet(beginHourDataToSave, endHourDataToSave,
            stationDataToSave, selectDayId.toString(), UserInfo.id,
            loginController.studentDay[selectDay.value].meet.first.id.toString()).then((value){
              if(value){
                editMode.value = false;
              }else{
                print('error');
                loading.value = false;
          }
        });
        Future.delayed(const Duration(milliseconds: 500)).then((value) async {
            await Api.login(UserInfo.studentId, UserInfo.password).then((value) async{
              if(value.id != -1) {
                loginController.studentDay.clear();
                loginController.studentDay.addAll(value.days);
                print(loginController.studentDay[selectDay.value].meet.length);
                resetValue();
                loading.value = false;
              }else{
                print('error login');
                loading.value = false;
              }
            });
        });
      }

      // if(newBeginHourValue.value == ''){
      //   print('begin ----');
      //   print(introController.beginHourList.indexWhere((h)=> h.hour == loginController.studentDay[selectDay.value].meet.first["begin_hour"]));
      // }
      // if(newEndHourValue.value == ''){
      //   print('end ------------');
      //   print(introController.endHourList.indexWhere((h)=> h.hour == loginController.studentDay[selectDay.value].meet.first["end_hour"]));
      // }
    }
  }

  resetValue(){
    beginHourDataToSave = '';
    endHourDataToSave = '';
    stationDataToSave = '';
    newBeginHourValue.value = '';
    newEndHourValue.value = '';
    newStationValue.value = '';
    cancelBeginHour.value = false;
    cancelEndHour.value = false;
  }

  deleteMeet(){
    String meetId = loginController.studentDay[selectDay.value].meet.first.id.toString();
    Api.checkInternet().then((value){
      if(value){
        Api.deleteMeet(meetId).then((value){
          if(value){
            print('successfully');
          }else{
            print('error');
          }
        });
      }else{

      }
    });
  }

  deleteMeetOperation() async {
    deleteMeet();
    editMode.value = false;
    Future.delayed(Duration(milliseconds: 500)).then((value) async {
        await Api.login(UserInfo.studentId, UserInfo.password).then((value) async{
          if(value.id != -1) {
            print('------------------');
            loginController.studentDay.clear();
            loginController.studentDay.addAll(value.days);
            print(loginController.studentDay[selectDay.value].meet.length);
          }else{
            print('error login');
          }
        });
    });
  }

}