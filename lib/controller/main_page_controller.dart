

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
          Fluttertoast.showToast(msg: message, fontSize: 14);
          return false;
        }else{
          Fluttertoast.cancel();
          return true;
        }
      }
    }else{
      pageController.animateToPage(0, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
      selectedIndex.value == 0;
      return false;
    }
  }



}