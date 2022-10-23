import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:kalamoon_final/services/messages.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view/no_internet_page.dart';
import '../view/notActivatePage.dart';
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
  RxBool signUpButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  reInit(int stationId)async{
    // print(loginController.studentDay[0].meet.length.toString()+":***");
    if(loginController.studentDay[0].meet.isNotEmpty){
      await Api.editAllMeet(stationId.toString(), UserInfo.id.toString());
    }else{
      await Api.addAllMeet(stationId.toString(), UserInfo.id.toString());
    }
    getData();
  }

  getData() async {
    Api.checkInternet().then((value)async{
      if(value){
        Api.getStartUpData().then((value){
          if(value.weekDays.isNotEmpty){
            weekDayList.value=value.weekDays;
            stationsList.value=value.stations;
            beginHourList.value=value.beginHour;
            endHourList.value=value.endHour;
            universityList.value=value.university;
            checkLogin();
          }else{
            ///reGetData
            getData();
          }
        }).catchError((err){
          print(err);
        });
      }else{
        await UserInfo.loadUserInformation();
        int id = -1;
        try{
         id = int.parse(UserInfo.id);
        }catch(err){
          print(err);
        }
        // print(id.toString() +"****************------*******");
        Future.delayed(const Duration(milliseconds: 500)).then((value){
          Get.to(()=>NoInternetPage(id))!.then((value) {
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

  createAccount() async {
    String message = Messages.createMessage;
    String number = '0934481988';
    if (Platform.isAndroid){
      // ignore: deprecated_member_use
      if(await canLaunch("https://wa.me/$number/?text=${Uri.parse(message)}")){
        // ignore: deprecated_member_use
        await launch("https://wa.me/$number/?text=${Uri.parse(message)}");
      }else{
        // App.error_msg(context, 'can\'t open Whatsapp');
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: number,
        );
        await launchUrl(launchUri);
      }
    }else if(Platform.isIOS){
      // ignore: deprecated_member_use
      if(await canLaunch("https://api.whatsapp.com/send?phone=$number=${Uri.parse(message)}")){
        // ignore: deprecated_member_use
        await launch("https://api.whatsapp.com/send?phone=$number=${Uri.parse(message)}");
      }else{
        // App.error_msg(context, 'can\'t open Whatsapp');
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: number,
        );
        await launchUrl(launchUri);
      }
    }
  }


}