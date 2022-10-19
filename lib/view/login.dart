import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../controller/login_controller.dart';
import '../widget/CustomTextField.dart';
import '../widget/custom_button.dart';
import '../widget/logo_container.dart';

class Login extends StatelessWidget {

  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        // ),
        body: Stack(
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
              color: AppStyle.grey.withOpacity(0.7),
            ),
            SingleChildScrollView(
              child: Container(
                height: AppStyle.getDeviceHeight(100, context),
                width: AppStyle.getDeviceWidth(100, context),
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Hero(
                      tag: 'introLogo',
                        child: LogoContainer(width: 40, height: 20)),
                    _inputField(context),
                    _signInOption(context),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: loginController.loading.value ?
              Container(
                width: Get.width,
                height: Get.height,
                color: Colors.white.withOpacity(0.2),
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 5),
                ),
              ) : Text(''),
            ),
          ],
        ),
      );
    });
  }

  _inputField(context){
    return Column(
      children: [
        CustomTextField(
          width: 80,
          height: 10,
          controller: loginController.studentId,
          prefixIcon: const Icon(Icons.person, color: Colors.white),
          suffixIcon: const Icon(Icons.numbers, color: Colors.white,size: 0),
          labelText: App_Localization.of(context).translate('student_id'),
          hintText: App_Localization.of(context).translate('enter_your_id'),
          keyboardType: TextInputType.number,
          textLength: 7,
          textFieldName: 'Student ID',
          textVisible: false,
          maxLength: 15,
          isValidate: true,
          underlineColor: Colors.white,
          darkLightMode: false,
        ),
        const SizedBox(height: 30),
        CustomTextField(
          width: 80,
          height: 10,
          controller: loginController.password,
          prefixIcon: const Icon(Icons.person, color: Colors.white),
          suffixIcon: GestureDetector(
            onTap: (){
              loginController.visiblePassword.value = !loginController.visiblePassword.value;
            },
            child: loginController.visiblePassword.value
                ?  Icon(Icons.visibility_off_outlined, color: Colors.white)
                :  Icon(Icons.visibility_outlined, color: Colors.white),
          ),
          labelText: App_Localization.of(context).translate('password'),
          hintText: App_Localization.of(context).translate('enter_password'),
          keyboardType: TextInputType.text,
          textLength: 4,
          textFieldName: 'Password',
          textVisible: loginController.visiblePassword.value,
          maxLength: 4,
          isValidate: true,
          underlineColor: Colors.white,
          darkLightMode: false,
        ),
        const SizedBox(height: 17),
        SizedBox(
          // color: Colors.red,
          width: AppStyle.getDeviceWidth(80, context),
          child: GestureDetector(
            onTap: () async {
              await loginController.forgetPassword();
            },
            child: Text(
              App_Localization.of(context).translate('forger_your_password'),
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }

  _signInOption(context){
    return Container(
      height: AppStyle.getDeviceHeight(20, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            flightShuttleBuilder: CommonTextStyle.flightShuttleBuilder,
            tag: 'button',
            child: CustomButton(
                width: 80,
                height: 7,
                text: App_Localization.of(context).translate('sign_in'),
                onPressed:(){
                  loginController.login(context);
                },
                color: AppStyle.lightRed,
                color2: AppStyle.darkRed,
                borderRadius: 10,
                borderColor: Colors.white,
                borderWidth: 0,
                border: false,
                textStyle: CommonTextStyle.textStyleForBigButton),
          ),
          // GestureDetector(
          //   onTap: (){
          //     Get.offNamed('/signUp');
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.only(bottom: 20),
          //     child: Center(
          //       child: Text(
          //           App_Localization.of(context).translate('Dont_have_account'),
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 14
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }



}
