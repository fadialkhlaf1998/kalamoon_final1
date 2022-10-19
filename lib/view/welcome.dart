import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalamoon_final/controller/intro_controller.dart';
import 'package:kalamoon_final/widget/confirm_dialog.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../widget/custom_button.dart';
import '../widget/logo_container.dart';

class Welcome extends StatelessWidget {

  IntroController introController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/new_background.jpg')
                      )
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height,
                  color: AppStyle.grey.withOpacity(0.5),
                ),
                Container(
                  width: AppStyle.getDeviceWidth(100, context),
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _logo(),
                      _welcomeText(context),
                      _chooseOption(context)
                    ],
                  ),
                ),
                ConfirmDialog(
                    width: 70,
                    height: 200,
                    title: 'create_account',
                    description: 'contact_create_account',
                    button1Text: 'cancel',
                    button2Text: 'contact',
                    button1Pressed:(){
                      introController.signUpButton.value = false;
                    },
                    button2Pressed:(){
                      introController.signUpButton.value = false;
                      introController.createAccount();
                    },
                    openDialog: introController.signUpButton.value,
                    errorConfirm: false
                ),
              ],
            )
        ),
      );
    });
  }

  _logo(){
    return const Hero(
      tag: 'introLogo',
      child: LogoContainer(
        height: 20,
        width: 50,
      ),
    );
  }
  
  _welcomeText(context){
    return SizedBox(
      width: AppStyle.getDeviceWidth(80, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              App_Localization.of(context).translate('welcome'),
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            App_Localization.of(context).translate('welcome_details'),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  _chooseOption(context){
    return Column(
      children: [
        Hero(
          flightShuttleBuilder: CommonTextStyle.flightShuttleBuilder,
          tag: 'button',
          child: CustomButton(
              width: 80,
              height: 7,
              text: App_Localization.of(context).translate('sign_in'),
              onPressed: (){
                Get.offNamed('/login');
              },
              color: AppStyle.lightRed,
              color2: AppStyle.darkRed,
              borderRadius: 15,
              borderColor: Colors.red,
              borderWidth: 0,
              border: false,
              textStyle: CommonTextStyle.textStyleForBigButton
          ),
        ),
        const SizedBox(height: 20),
        Hero(
          flightShuttleBuilder: CommonTextStyle.flightShuttleBuilder,
          tag: 'button2',
          child: CustomButton(
              width: 80,
              height: 7,
              text: App_Localization.of(context).translate('sign_up'),
              onPressed: (){
                introController.signUpButton.value = true;
              },
              color: Colors.transparent,
              color2: Colors.transparent,
              borderRadius: 15,
              borderColor: Colors.white,
              borderWidth: 1.5,
              border: true,
              textStyle: CommonTextStyle.textStyleForBigButton
          ),
        ),
        const SizedBox(height: 60),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: const Center(
            child: Text(
                'لكم منّا كلُّ نبض',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white
              ),
            ),
          ),
        )
        // CustomButton(
        //     width: 40,
        //     height: 7,
        //     text: App_Localization.of(context).translate('change_language'),
        //     onPressed: (){
        //       Get.toNamed('/language');
        //     },
        //     color: Colors.transparent,
        //     color2: Colors.transparent,
        //     borderRadius: 20,
        //     borderColor: Colors.white,
        //     borderWidth: 1.5,
        //     border: false,
        //     textStyle: CommonTextStyle.textStyleForSmallButton
        // ),
      ],
    );
  }

}
