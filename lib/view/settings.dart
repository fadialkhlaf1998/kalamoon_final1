import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kalamoon_final/controller/intro_controller.dart';
import 'package:kalamoon_final/services/api.dart';
import 'package:kalamoon_final/widget/custom_button.dart';
import '../widget/confirm_dialog.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../services/myTheme.dart';
import '../services/store.dart';
import '../controller/settings_controller.dart';

class Settings extends StatelessWidget {

  SettingsController settingsController = Get.find();

  int heightItem = 10;

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 10),
                      _title(context),
                      _menu(context),
                      const SizedBox(height: 20),
                      settingsController.loading.value?
                          Container(
                            width: AppStyle.getDeviceWidth(90, context),
                            height: AppStyle.getDeviceHeight(7, context),
                            child: Center(
                              child: LinearProgressIndicator(),
                            ),
                          )
                          :
                      CustomButton(
                          width: 90,
                          height: 7,
                          text: App_Localization.of(context).translate('delete_account'),
                          onPressed: ()async{
                            settingsController.loading.value = true;
                            await Api.deleteAccount();
                            settingsController.loading.value = false;
                            settingsController.logout();
                          },
                          color: AppStyle.red,
                          color2: AppStyle.red,
                          borderRadius: 10,
                          borderColor: Colors.white,
                          borderWidth: 0,
                          border: false,
                          textStyle: CommonTextStyle.textStyleForBigButton),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                ConfirmDialog(
                    width: 80,
                    height: 200,
                    title: 'warning',
                    description: 'do_you_went_to_logout',
                    button1Text: 'cancel',
                    button2Text: 'ok',
                    button1Pressed: (){
                      settingsController.openDialogLogout.value = false;
                    },
                    button2Pressed: (){
                      settingsController.logout();
                    },
                    openDialog: settingsController.openDialogLogout.value,
                    errorConfirm: false
                ),
              ],
            )
        ),
      );
    });
  }

  _title(context){
    return Container(
      width: AppStyle.getDeviceWidth(100, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/settings.svg',
            width: AppStyle.getDeviceWidth(10, context),
            height: AppStyle.getDeviceWidth(10, context),
            color: Theme.of(context).dividerColor,
          ),
          const SizedBox(width: 10),
          Text(
              App_Localization.of(context).translate('settings'),
             style: TextStyle(
               color: Theme.of(context).dividerColor,
               fontSize: 26,
               fontWeight: FontWeight.bold
             ),
          )
        ],
      ),
    );
  }

  _menu(context){
    return Container(
      width: AppStyle.getDeviceWidth(90, context),
      height: AppStyle.getDeviceHeight(70, context),
      // color: Colors.red,
      child: Column(
        children: [
          _language(context),
          _changePassword(context),
          _darkMode(context),
          _station(context),
         Obx(() =>  settingsController.updateLoading.value?
         Container(
           width: AppStyle.getDeviceWidth(90, context),
           height: AppStyle.getDeviceHeight(7, context),
           child: Center(
             child: LinearProgressIndicator(),
           ),
         )
             :
         _updateApp(context),),
          _logOut(context)
        ],
      )
    );
  }

  _language(context){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            settingsController.openLanguageChooseMenu();
            // if(Global.langCode == 'en'){
            //   CommonTextStyle.fontFamilyName = 'Muli';
            // }
            // Restart.restartApp();
          },
          child: Container(
            color: Colors.transparent,
            height: AppStyle.getDeviceHeight(heightItem, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  App_Localization.of(context).translate('language'),
                  style: CommonTextStyle.settingsTextStyle1(context),
                ),
                // _dropDownMenu(context),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 500),
                  turns: settingsController.openLanguageMenu.value ? - 0.25 : 0,
                  // angle: settingsController.openLanguageMenu.value ? - math.pi / 2 : 0,
                  child: const Icon(Icons.arrow_forward_ios,size: 20, key: ValueKey(1)),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          width: AppStyle.getDeviceWidth(100, context),
          height: AppStyle.getDeviceHeight( settingsController.openLanguageMenu.value ? heightItem -3 : 0, context),
          child: ListView.builder(
            itemCount: settingsController.languageList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              print(settingsController.languageChooseIndex.value);
              return GestureDetector(
                onTap: (){
                  settingsController.changeLanguageFromMenu(index, context);
                  },
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: settingsController.languageChooseIndex.value == index ? 2 : 1,
                          color: settingsController.languageChooseIndex.value == index ? AppStyle.lightRed : Theme.of(context).dividerColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(
                      settingsController.languageList[index],
                      style: TextStyle(
                          color: settingsController.languageChooseIndex.value == index ? AppStyle.lightRed : Theme.of(context).dividerColor,
                          fontSize: CommonTextStyle.smallTextStyle,
                          fontWeight: settingsController.languageChooseIndex.value == index ? FontWeight.bold : FontWeight.normal
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // _dropDownMenu(context){
  //   return Obx((){
  //     return  SizedBox(
  //       child: DropdownButton(
  //         underline: SizedBox(),
  //         value: settingsController.dropDownValue.value == 'none' ? null : settingsController.dropDownValue.value,
  //         icon: const Icon(Icons.keyboard_arrow_down),
  //         items: settingsController.languageList.map((String items) {
  //           return DropdownMenuItem(
  //             value: items,
  //             child: Text(items),
  //           );
  //         }).toList(),
  //         style: CommonTextStyle.settingsSmallTextStyle(context),
  //         dropdownColor: Theme.of(context).backgroundColor,
  //         onChanged: (value){
  //           if(value == 'English'){
  //             settingsController.changeLanguage(context, 'en');
  //           }else{
  //             settingsController.changeLanguage(context, 'ar');
  //           }
  //           settingsController.dropDownValue.value = value.toString();
  //         },
  //       ),
  //     );
  //   });
  // }

  _changePassword(context){
    return GestureDetector(
      onTap: (){
        Get.toNamed('/changePassword');
      },
      child: Container(
        color: Colors.transparent,
        height: AppStyle.getDeviceHeight(heightItem, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              App_Localization.of(context).translate('change_password'),
              style: CommonTextStyle.settingsTextStyle1(context),
            ),
            Icon(Icons.arrow_forward_ios, size: 20,color: Theme.of(context).dividerColor)
          ],
        ),
      ),
    );
  }

  _darkMode(context){
    return Obx((){
      return  Container(
        color: Colors.transparent,
        height: AppStyle.getDeviceHeight(heightItem, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MyTheme.isDarkTheme.value ? App_Localization.of(context).translate('dark_mode') : App_Localization.of(context).translate('light_mode'),
              style: CommonTextStyle.settingsTextStyle1(context),
            ),
            GestureDetector(
              onTap: ()async{
                settingsController.changeMode(context);
                await Store.saveTheme(MyTheme.isDarkTheme.value);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: MyTheme.isDarkTheme.value ? Image.asset('assets/icons/dark_lamp2.png') : Image.asset('assets/icons/light_lamp.png'),
                ),
                // child: Switch(
                //   value: MyTheme.isDarkTheme.value,
                //   onChanged: (value) {
                //     settingsController.changeMode(context);
                //     Store.saveTheme(!value);
                //     // MyTheme.isDarkTheme.value = value;
                //   },
                // ),
              ),
            )
          ],
        ),
      );
    });
  }

  _station(context){
    return GestureDetector(
      onTap: (){
        IntroController introController = Get.find();
        Get.toNamed('/selectionMenu',arguments: ['الموقف المعتمد', 'selection2', introController.stationsList]);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        height: AppStyle.getDeviceHeight(heightItem, context),
       decoration: BoxDecoration(
         color: settingsController.stationLight.value ? Colors.red.withOpacity(0.5) : Colors.transparent,
         borderRadius: BorderRadius.circular(20),
       ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              App_Localization.of(context).translate('station'),
              style:CommonTextStyle.settingsTextStyle1(context),
            ),
            Icon(Icons.edit_location_alt_outlined,color: Theme.of(context).dividerColor)
          ],
        ),
      ),
    );
  }
  _updateApp(context){
    return GestureDetector(
      onTap: (){
        print('-------------');
        settingsController.updateApp(context);
      },
      child: Container(
        color: Colors.transparent,
        height: AppStyle.getDeviceHeight(heightItem, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              App_Localization.of(context).translate('update_app'),
              style:CommonTextStyle.settingsTextStyle1(context),
            ),
            Icon(Icons.update,color: Theme.of(context).dividerColor)
          ],
        ),
      ),
    );
  }
  _logOut(context){
    return GestureDetector(
      onTap: (){
        print('-------------');
        settingsController.openDialogLogout.value = true;
      },
      child: Container(
        color: Colors.transparent,
        height: AppStyle.getDeviceHeight(heightItem, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              App_Localization.of(context).translate('log_out'),
              style:CommonTextStyle.settingsTextStyle1(context),
            ),
            Icon(Icons.logout,color: Theme.of(context).dividerColor)
          ],
        ),
      ),
    );
  }



}
