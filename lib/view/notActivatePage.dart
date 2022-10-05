import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../controller/not_activation_controller.dart';
import '../services/app_style.dart';
import '../services/myTheme.dart';
import '../view/intro.dart';
import '../widget/custom_button.dart';

class NotActivatePage extends StatelessWidget {

  NotActivationController notActivationController = Get.put(NotActivationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: SafeArea(
        child: Center(
          child: Container(
              width: Get.width,
              height: Get.height * 0.5,
              color: Theme
                  .of(context)
                  .backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    App_Localization.of(context).translate('not_activation'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Khebrat',
                      fontSize: 18,
                      color: MyTheme.isDarkTheme.value ? Colors.white : AppStyle
                          .lightRed,
                    ),
                  ),
                  Image.asset(
                    'assets/images/no_internet.png', width: Get.width * 0.8,
                    fit: BoxFit.cover,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          width: 40,
                          height: 6,
                          text: App_Localization.of(context).translate('back'),
                          onPressed: () {
                            Get.back();
                          },
                          color: Colors.grey,
                          color2: Colors.grey,
                          borderRadius: 10,
                          borderColor: Colors.white,
                          borderWidth: 1,
                          border: false,
                          textStyle: CommonTextStyle.textStyleForBigButton
                      ),
                      CustomButton(
                          width: 40,
                          height: 6,
                          text: App_Localization.of(context).translate(
                              'call_us'),
                          onPressed: () {
                            // Get.back();
                            _showMyDialog(context);
                          },
                          color: AppStyle.lightRed,
                          color2: AppStyle.darkRed,
                          borderRadius: 10,
                          borderColor: Colors.white,
                          borderWidth: 1,
                          border: false,
                          textStyle: CommonTextStyle.textStyleForBigButton
                      ),
                    ],
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
              App_Localization.of(context).translate('option_call'),
            style: TextStyle(
              fontFamily: 'Khebrat',
              fontSize: 18,
              color: MyTheme.isDarkTheme.value ? Colors.white : AppStyle.lightRed,
            ),
          ),
          content: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                        notActivationController.whatsapp(context);
                      },
                      child: Icon(
                          Icons.whatsapp,
                        color: MyTheme.isDarkTheme.value ? Colors.white : AppStyle.lightRed,
                        size: 36,
                      ),
                    ),
                    Text(
                        App_Localization.of(context).translate('whatsapp'),
                      style: TextStyle(
                        fontFamily: 'Khebrat',
                        fontSize: 13,
                        color: MyTheme.isDarkTheme.value ? Colors.white : AppStyle.lightRed,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                        notActivationController.phone();
                      },
                      child: Icon(
                        Icons.phone,
                        color:MyTheme.isDarkTheme.value ? Colors.white : AppStyle.lightRed,
                        size: 36,
                      ),
                    ),
                    Text(
                        App_Localization.of(context).translate('phone'),
                      style: TextStyle(
                        fontFamily: 'Khebrat',
                        fontSize: 13,
                        color: MyTheme.isDarkTheme.value ? Colors.white : AppStyle.lightRed,
                      ),)
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                  App_Localization.of(context).translate('back'),
                style: TextStyle(
                  fontFamily: 'Khebrat',
                  fontSize: 13,
                  color: MyTheme.isDarkTheme.value ? Colors.white : AppStyle.lightRed,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }



}
