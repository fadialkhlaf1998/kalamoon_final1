import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../view/intro.dart';
import '../widget/custom_button.dart';

class NoInternetPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: Get.width,
            height: Get.height * 0.5,
            color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  App_Localization.of(context).translate('no_internet'),
                  textAlign: TextAlign.center,
                  style: CommonTextStyle.textStyleForBigButton1,
                ),
                Image.asset('assets/images/no_internet.png',width: Get.width * 0.8 ,fit: BoxFit.cover,),
                CustomButton(
                    width: 40,
                    height: 6,
                    text: App_Localization.of(context).translate('try_again'),
                    onPressed: (){
                      Get.back();
                    },
                    color: AppStyle.lightRed,
                    color2: AppStyle.darkRed,
                    borderRadius: 10,
                    borderColor: Colors.white,
                    borderWidth: 1,
                    border: false,
                    textStyle: CommonTextStyle.textStyleForBigButton
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
