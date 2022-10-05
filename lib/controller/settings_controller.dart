

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../services/user_info.dart';
import '../services/global.dart';
import '../services/myTheme.dart';
import '../main.dart';

class SettingsController extends GetxController{

  List<String> titleList = ['Language', 'Change password', 'Dark mode', 'Log out'];
  List<String> languageList = ['English', 'العربية'];
  RxString dropDownValue = 'none'.obs;
  Rx<MyTheme> myTheme = MyTheme().obs;
  RxBool openLanguageMenu = false.obs;
  RxInt languageChooseIndex = 0.obs;
  RxBool openDialogLogout = false.obs;


  @override
  void onInit() {
    super.onInit();
    fillLanguageIndex();
  }

  fillLanguageIndex(){
    if(Global.langCode == 'ar'){
      languageChooseIndex.value == 1;
    }
  }

  changeLanguage(BuildContext context, String language){
    MyApp.set_local(context,Locale(language));
    Get.updateLocale(Locale(language));
    Global.saveLanguage(context, language);
    Global.loadLanguage();
  }

  changeMode(BuildContext context){
    myTheme.value.toggleTheme();
    MyApp.setTheme(context);
  }

  openLanguageChooseMenu(){
    openLanguageMenu.value = !openLanguageMenu.value;
  }

  changeLanguageFromMenu(index, context){
    if(index == 0){
      changeLanguage(context, 'en');
      languageChooseIndex.value = 0;
    }else{
      changeLanguage(context, 'ar');
      languageChooseIndex.value = 1;
    }
    Future.delayed(Duration(milliseconds: 500)).then((value){
      openLanguageMenu.value = false;
    });
  }

  logout(){
    UserInfo.clear();

    openDialogLogout.value = false;
    Get.offAllNamed('/welcome');
  }


}