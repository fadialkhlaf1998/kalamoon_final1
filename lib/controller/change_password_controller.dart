

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
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
              Get.snackbar(
                  App_Localization.of(context).translate('successfully'),
                  App_Localization.of(context).translate('change_password_successfully'),
                  margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.check)
              );
              loading.value = false;
              newPassword.clear();
              confirmPassword.clear();
              Get.offAllNamed('/login');
            }else{
              Get.snackbar(
                App_Localization.of(context).translate('error'),
                App_Localization.of(context).translate('wrong'),
                margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
                backgroundColor: AppStyle.red,
                icon: const Icon(Icons.warning),
              );
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
      Get.snackbar(
        App_Localization.of(context).translate('error'),
        App_Localization.of(context).translate('password_empty'),
        margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
        backgroundColor: AppStyle.red,
        icon: const Icon(Icons.warning),
      );
    }else if(newPassword.text != confirmPassword.text){
        Get.snackbar(
          App_Localization.of(context).translate('error'),
          App_Localization.of(context).translate('password_match'),
          margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
          backgroundColor: AppStyle.red,
          icon: const Icon(Icons.warning),
        );
      }else{
        showDialog.value = true;
      }
    }




}