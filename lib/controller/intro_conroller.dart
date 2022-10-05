import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../view/no_internet_page.dart';
import '../view/notActivatePage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../model/start_up_data.dart';
import '../controller/login_controller.dart';
import '../services/api.dart';
import '../services/user_info.dart';

class IntroController extends GetxController{

  LoginController loginController = Get.put(LoginController());
  RxList<WeekDay> weekDayList = <WeekDay>[].obs;
  RxList<Station> stationsList = <Station>[].obs;
  RxList<Hour> beginHourList = <Hour>[].obs;
  RxList<Hour> endHourList = <Hour>[].obs;
  RxList<University> universityList = <University>[].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    // checkLogin();
  }

  getData() async {
    Api.checkInternet().then((value){
      if(value){
        Api.getStartUpData().then((value){
          if(value.weekDays.isNotEmpty){
            weekDayList.addAll(value.weekDays);
            stationsList.addAll(value.stations);
            beginHourList.addAll(value.beginHour);
            endHourList.addAll(value.endHour);
            universityList.addAll(value.university);
            checkLogin();
          }else{
            print('no data');
          }
        });
      }else{
        print('no internet');

        Future.delayed(const Duration(milliseconds: 500)).then((value){
          Get.to(()=>NoInternetPage())!.then((value) {
            getData();
          });
        });
      }
    });
  }


  checkLogin() async {

    // String? identifier = await UniqueIdentifier.serial;
    // print(identifier);


    await UserInfo.loadUserInformation();
    if(UserInfo.studentId == '-1'){
      Timer(const Duration(milliseconds: 2000),(){
        Get.offNamed('/welcome');
      });
    }else{
      Api.autoLogin(UserInfo.studentId, UserInfo.password).then((value){
        if(value.id != -1){
          if(value.isActive == 1){
            loginController.studentDay.clear();
            loginController.studentDay.addAll(value.days);
            Get.offAllNamed('/mainPage');
          }else{
            Get.to(NotActivatePage());
          }
        }else{
          Get.offAllNamed('/welcome');
        }
      });
    }
  }


}