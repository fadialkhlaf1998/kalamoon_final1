import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../controller/change_language_controller.dart';
import '../widget/custom_button.dart';
import '../widget/logo_container.dart';

class ChangeLanguage extends StatelessWidget {

  ChangeLanguageController changeLanguageController = Get.put(ChangeLanguageController());


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/new_background.jpg')
                )
            ),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            color: AppStyle.grey.withOpacity(0.7),
          ),
          Container(
            //color: Theme.of(context).backgroundColor,
            width: AppStyle.getDeviceWidth(100, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _logo(),
                _languageListOption(context),
                _saveButton(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _logo(){
    return const Hero(
      tag: 'introLogo',
      child: LogoContainer(
        height: 20,
        width: 30,
      ),
    );
  }
  
  _languageListOption(context){
      return SizedBox(
        width: AppStyle.getDeviceWidth(80, context),
        child: Column(
          children: [
            Text(
                App_Localization.of(context).translate('choose_your_language'),
              style: TextStyle(
                fontFamily: 'Muli',
                fontSize: CommonTextStyle.bigTextStyle,
                color: Theme.of(context).dividerColor
              )
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: changeLanguageController.languageList.length,
                itemBuilder: (BuildContext context, index){
                  return Obx((){
                    return GestureDetector(
                      onTap: (){
                        changeLanguageController.chooseLanguageIndex.value = index;
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: AppStyle.getDeviceWidth(80, context),
                            height: AppStyle.getDeviceHeight(9, context),
                            decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                borderRadius: BorderRadius.circular(20),
                                border: changeLanguageController.chooseLanguageIndex.value == index
                                    ? Border.all(color: AppStyle.lightRed)
                                    : Border.all(color: Colors.transparent)
                            ),
                          ),
                          changeLanguageController.chooseLanguageIndex.value == index
                              ? Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: AppStyle.getDeviceWidth(80, context),
                            height: AppStyle.getDeviceHeight(9, context),
                            decoration: BoxDecoration(
                              color: AppStyle.lightRed.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ) : Text(''),
                          Container(
                            width: AppStyle.getDeviceWidth(80, context),
                            height: AppStyle.getDeviceHeight(9, context),
                            margin: const EdgeInsets.only(bottom: 20),
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Image.asset(
                                      'assets/icons/${changeLanguageController.languageListIcon[index]}',
                                      width: AppStyle.getDeviceHeight(5, context),
                                      height: AppStyle.getDeviceHeight(5, context),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      changeLanguageController.languageList[index],
                                      style: CommonTextStyle.defaultTextStyle(context),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: AppStyle.getDeviceHeight(7, context),
                                  width: changeLanguageController.chooseLanguageIndex.value == index ? 20 : 0,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage('assets/icons/checked.png'),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      );
  }

  _saveButton(context){
      return Hero(
        flightShuttleBuilder: CommonTextStyle.flightShuttleBuilder,
        tag: 'button',
        child: CustomButton(
            width: 80,
            height: 8,
            text: App_Localization.of(context).translate('save_language'),
            onPressed: (){
              changeLanguageController.changeLanguage(context);
              // Get.back();
            },
            color: AppStyle.lightRed,
            color2: AppStyle.darkRed,
            borderRadius: 20,
            borderColor: Colors.red,
            borderWidth: 0,
            border: false,
            textStyle: CommonTextStyle.textStyleForBigButton
        ),
      );
  }

}
