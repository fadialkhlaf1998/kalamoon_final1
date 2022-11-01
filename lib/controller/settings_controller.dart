

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kalamoon_final/app_localization.dart';
import 'package:kalamoon_final/services/app_style.dart';
import 'package:new_version/new_version.dart';
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
  RxBool stationLight = false.obs;

  RxBool loading = false.obs;
  RxBool updateLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fillLanguageIndex();
  }

  updateApp(BuildContext context)async{
    try{
      updateLoading.value = true;
      final newVersion = NewVersion(
        iOSId: 'com.Fadi.Kalamoon',
        androidId: 'com.fadi.kalamoon',
      );
      print(updateLoading.value);
      final state = await newVersion.getVersionStatus();
      updateLoading.value = true;

      if(state !=null){
        if(state.canUpdate){
          newVersion.showUpdateDialog(context: context, versionStatus: state);
        }else{
          AppStyle.noteNotification(context,"update_app", "your_app_up_to_date");
        }
      }else{
        print('null');
      }
    }catch(e){
      print(e);
      updateLoading.value = false;
    }

  }

  fillLanguageIndex(){
    if(Global.langCode == 'ar'){
      languageChooseIndex.value = 1;
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
    Future.delayed(const Duration(milliseconds: 500)).then((value){
      openLanguageMenu.value = false;
    });
  }

  logout(){
    UserInfo.clear();
    openDialogLogout.value = false;
    Get.offAllNamed('/welcome');
  }


}