
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../controller/sign_up_controller.dart';
import '../widget/CustomTextField.dart';
import '../widget/custom_button.dart';

class SignUp extends StatelessWidget {

  SignUpController signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: AppStyle.getDeviceWidth(100, context),
                height: AppStyle.getDeviceHeight(100, context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/background1.png')
                    )
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: AppStyle.getDeviceWidth(100, context),
                  height: AppStyle.getDeviceHeight(100, context) - (MediaQuery.of(context).padding.bottom + MediaQuery.of(context).padding.top),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const SizedBox(height: 0),
                        _inputField(context),
                        Hero(
                          flightShuttleBuilder: CommonTextStyle.flightShuttleBuilder,
                          tag: 'button2',
                          child: CustomButton(
                              width: 80,
                              height: 7,
                              text: App_Localization.of(context).translate('sign_up'),
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  print('fadi adadadad');
                                }
                              },
                              color: AppStyle.lightRed,
                              color2: AppStyle.darkRed,
                              borderRadius: 10,
                              borderColor: Colors.white,
                              borderWidth: 0,
                              border: false,
                              textStyle: CommonTextStyle.textStyleForBigButton
                          ),
                        ),
                      GestureDetector(
                        onTap: (){
                          Get.offNamed('/login');
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            App_Localization.of(context).translate('have_account_login'),
                            style: CommonTextStyle.textStyleForSmallButton,
                          ),
                        ),
                      )
                      //  const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

            ]
          ),
        )
      );
    });
  }

  _inputField(context){
    return Column(
      children: [
        CustomTextField(
            width: 80,
            height: 9,
            controller: signUpController.name,
            prefixIcon: Icon(Icons.add,size: 0,),
            suffixIcon: Icon(Icons.add,size: 0),
            labelText: App_Localization.of(context).translate('name'),
            hintText: App_Localization.of(context).translate('enter_your_name'),
            keyboardType: TextInputType.text,
            textLength: 5,
            textFieldName: 'Name',
            textVisible: false,
            maxLength: 25,
          isValidate: true,
          underlineColor: Colors.white,
          darkLightMode: false,
        ),
        const SizedBox(height: 30),
        CustomTextField(
            width: 80,
            height: 9,
            controller: signUpController.studentId,
            prefixIcon: Icon(Icons.add,size: 0,),
            suffixIcon: Icon(Icons.add,size: 0,),
            labelText: App_Localization.of(context).translate('student_id'),
            hintText: App_Localization.of(context).translate('enter_your_id'),
            keyboardType: TextInputType.number,
            textLength: 9,
            textFieldName: 'ID',
            textVisible: false,
          maxLength: 9,
          isValidate: true,
          underlineColor: Colors.white,
          darkLightMode: false,
        ),
        const SizedBox(height: 30),
        CustomTextField(
            width: 80,
            height: 9,
            controller: signUpController.phone,
            prefixIcon: Icon(Icons.add,size: 0,),
            suffixIcon: Icon(Icons.add,size: 0,),
            labelText: App_Localization.of(context).translate('phone'),
            hintText: App_Localization.of(context).translate('enter_your_phone_number'),
            keyboardType: TextInputType.phone,
            textLength: 10,
            textFieldName: 'Phone',
            textVisible: false,
          maxLength: 10,
          isValidate: true,
          underlineColor: Colors.white,
          darkLightMode: false,
        ),
        const SizedBox(height: 30),
        CustomTextField(
            width: 80,
            height: 9,
            controller: signUpController.email,
            prefixIcon: Icon(Icons.add,size: 0,),
            suffixIcon: Icon(Icons.add,size: 0,),
            labelText: App_Localization.of(context).translate('email_optional'),
            hintText: App_Localization.of(context).translate('enter_your_email'),
            keyboardType: TextInputType.emailAddress,
            textLength: 40,
            textFieldName: 'Email',
            textVisible: false,
          maxLength: 40,
          isValidate: false,
          underlineColor: Colors.white,
          darkLightMode: false,
        ),
        const SizedBox(height: 30),
        CustomTextField(
            width: 80,
            height: 10,
            controller: signUpController.password,
            prefixIcon: Icon(Icons.add,size: 0,),
            suffixIcon: GestureDetector(
              onTap: (){
                signUpController.visiblePassword.value = !signUpController.visiblePassword.value;
              },
              child: signUpController.visiblePassword.value
                  ?  const Icon(Icons.visibility_outlined, color: Colors.white)
                  :  const Icon(Icons.visibility_off_outlined, color: Colors.white),
            ),
            labelText: App_Localization.of(context).translate('password'),
            hintText: App_Localization.of(context).translate('enter_password'),
            keyboardType: TextInputType.visiblePassword,
            textLength: 8,
            textFieldName: 'Password',
            textVisible: signUpController.visiblePassword.value,
          maxLength: 40,
          isValidate: true,
          underlineColor: Colors.white,
          darkLightMode: false,
        ),
      ],
    );
  }



}
