
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../services/global.dart';
import '../view/notActivatePage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/user_model.dart';
import '../services/user_info.dart';
import '../services/api.dart';

class LoginController extends GetxController{

  TextEditingController studentId = TextEditingController();
  TextEditingController password = TextEditingController();
  RxList<Day> studentDay = <Day>[].obs;
  RxBool visiblePassword = true.obs;
  RxBool loading = false.obs;

  // Future login

  Future login(BuildContext context) async {
    if(studentId.text.isEmpty){
      Get.snackbar(
          App_Localization.of(context).translate('warning'),
          App_Localization.of(context).translate('studentID_empty'),
        margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
        backgroundColor: AppStyle.red,
        icon: const Icon(Icons.warning)
      );
    }else if (password.text.isEmpty){
      Get.snackbar(
          App_Localization.of(context).translate('warning'),
          App_Localization.of(context).translate('password_empty'),
          margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
          backgroundColor: AppStyle.red,
          icon: const Icon(Icons.warning)
      );
    }else if(password.text.length < 4){
      Get.snackbar(
          App_Localization.of(context).translate('warning'),
          App_Localization.of(context).translate('password_length'),
          margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
          backgroundColor: AppStyle.red,
          icon: const Icon(Icons.warning)
      );
    }else{
      loading.value = true;
      Api.checkInternet().then((value){
        if(value){
          Api.login(studentId.text, password.text).then((value) async {
            if(value.id != -1){
              if(value.rule == 'user'){
                if(value.isActive == 1){
                  loginUserOperation(value, context);
                }else{
                  loading.value = false;
                  Get.to(NotActivatePage());
                }
              }
            }else if(Global.adminRule == 'sub-admin'){
              // Global.adminId = value.id.toString();
              // Global.adminToken = value.token.toString();
              print('-----------Here Admin Token---------');
              print(Global.adminToken);
              print(Global.adminId);
              subAdminOperation(context);
            }else{
              /// todo
              /// No user with this information
              print('error');
              loading.value = false;
              Get.snackbar(
                  App_Localization.of(context).translate('error'),
                  App_Localization.of(context).translate('email_password_wrong'),
                  margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
                  backgroundColor: AppStyle.red,
                  icon: const Icon(Icons.warning),
              );
            }
          });
        }else{
          /// todo
          /// on internet
          print(' on internet page');
          loading.value = false;
        }
      });
    }
  }

  loginUserOperation(value,context) async {
    print('successfully');
    studentDay.clear();
    studentDay.addAll(value.days);
    await UserInfo.saveUserInformation(studentId.text, value.phone, value.email, password.text, value.name,value.token, value.id.toString());
    await UserInfo.loadUserInformation();
    loading.value = false;
    studentId.clear();
    password.clear();
    Get.snackbar(
        App_Localization.of(context).translate('welcome'),
        App_Localization.of(context).translate('success_login'),
        margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check)
    );
    Get.offAllNamed('/mainPage');
    // Get.to(NotActivatePage());
  }

  subAdminOperation(context){
    studentId.clear();
    password.clear();
    Get.snackbar(
        App_Localization.of(context).translate('welcome'),
        App_Localization.of(context).translate('subAdmin_account'),
        margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check)
    );
    Get.offAllNamed('/mainPageAdmin');
  }


  forgetPassword() async {
    String message = "";
    String number = '0934481988';
    if (Platform.isAndroid){
      if(await canLaunch("https://wa.me/${number}/?text=${Uri.parse(message)}")){
    await launch("https://wa.me/${number}/?text=${Uri.parse(message)}");
    }else{
    // App.error_msg(context, 'can\'t open Whatsapp');
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: number,
        );
        await launchUrl(launchUri);
    }
    }else if(Platform.isIOS){
    if(await canLaunch("https://api.whatsapp.com/send?phone=${number}=${Uri.parse(message)}")){
    await launch("https://api.whatsapp.com/send?phone=${number}=${Uri.parse(message)}");
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