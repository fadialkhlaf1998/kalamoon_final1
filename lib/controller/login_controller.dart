
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalamoon_final/services/messages.dart';
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
      AppStyle.errorNotification(context, 'warning', 'studentID_empty');
    }else if (password.text.isEmpty){
      AppStyle.errorNotification(context, 'warning', 'password_empty');
    }else if(password.text.length < 4){
      AppStyle.errorNotification(context, 'warning', 'password_length');
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
              // print('-----------Here Admin Token---------');
              // print(Global.adminToken);
              // print(Global.adminId);
              subAdminOperation(context);
            }else{
              print('error');
              loading.value = false;
              AppStyle.errorNotification(context, 'warning', 'email_password_wrong');
            }
          });
        }else{
          loading.value = false;
        }
      });
    }
  }

  loginUserOperation(value,context) async {
    print('successfully');
    studentDay.clear();
    studentDay.addAll(value.days);

    await UserInfo.saveUserInformation(studentId.text, value.nationalId, value.phone, value.email, password.text, value.name,value.token, value.id.toString());
    await UserInfo.loadUserInformation();
    loading.value = false;
    studentId.clear();
    password.clear();
    AppStyle.successNotification(context, 'welcome', 'success_login');
    Get.offAllNamed('/mainPage');
    // Get.to(NotActivatePage());
  }

  subAdminOperation(context){
    studentId.clear();
    password.clear();
    AppStyle.successNotification(context, 'welcome', 'subAdmin_account');
    Get.offAllNamed('/mainPageAdmin');
  }


  forgetPassword() async {
    String message = Messages.forgetPassword;
    String number = '+963934481988';
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