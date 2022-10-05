import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/global.dart';
import '../main.dart';

class ChangeLanguageController extends GetxController{

  var languageList = ['العربية', 'English'];
  var languageListIcon = ['arabic.png', 'english.png'];

  RxInt chooseLanguageIndex = (0).obs;

  @override
  void onInit() {
    if(Global.langCode == 'en'){
      chooseLanguageIndex.value = 1;
    }
  }

  changeLanguage(BuildContext context){
    String language = 'en';
    if(chooseLanguageIndex.value == 0){
      language = 'ar';
    }
    MyApp.set_local(context,Locale(language));
    Get.updateLocale(Locale(language));
    Global.saveLanguage(context, language);
    Global.loadLanguage();
  }
}