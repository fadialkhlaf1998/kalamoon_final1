

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kalamoon_final/services/app_style.dart';
import 'package:kalamoon_final/services/myTheme.dart';
import '../app_localization.dart';

class MainPageController extends GetxController{

  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  DateTime timeBackPressed = DateTime.now();


  backButton(context, homeController){
    if(selectedIndex.value == 0){
      if(homeController.editMode.value){
        homeController.editMode.value = false;
        return false;
      }else{
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if(isExitWarning){
          String message = App_Localization.of(context).translate('press_back_to_exit');
          Fluttertoast.showToast(
              msg: message,
              fontSize: 15,
            backgroundColor: Theme.of(context).dividerColor,
            textColor: MyTheme.isDarkTheme.value ? AppStyle.red : Colors.white
          );
          return false;
        }else{
          Fluttertoast.cancel();
          return true;
        }
      }
    }else{
      selectedIndex.value = 0;
      pageController.animateToPage(0, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
      return false;
    }
  }



}