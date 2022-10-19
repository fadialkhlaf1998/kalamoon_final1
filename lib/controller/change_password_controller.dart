

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api.dart';
import '../services/app_style.dart';
import '../view/no_internet_page.dart';

class ChangePasswordController extends GetxController{

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool visibleOldPassword = true.obs;
  RxBool visibleNewPassword = true.obs;
  RxBool showDialog = false.obs;
  RxBool loading = false.obs;



  save(context) async {

      Api.checkInternet().then((value){
        if(value){
          loading.value = true;
          Api.changePassword(newPassword.text).then((value){
            if(value){
              AppStyle.successNotification(context, 'successfully','change_password_successfully');
              loading.value = false;
              newPassword.clear();
              confirmPassword.clear();
              Get.offAllNamed('/login');
            }else{
              AppStyle.errorNotification(context, 'error', 'wrong');
              loading.value = false;
            }
          });
        }else{
          Future.delayed(const Duration(milliseconds: 500)).then((value){
            Get.to(()=>NoInternetPage(-1));
          });
          loading.value = false;
        }
      });
    }


    checkChangePassword(context){
      FocusManager.instance.primaryFocus?.unfocus();
      if(newPassword.text.isEmpty || confirmPassword.text.isEmpty){
        AppStyle.errorNotification(context, 'error', 'password_empty');
    }else if(newPassword.text != confirmPassword.text){
        AppStyle.errorNotification(context, 'error', 'password_match');
      }else{
        showDialog.value = true;
      }
    }




}