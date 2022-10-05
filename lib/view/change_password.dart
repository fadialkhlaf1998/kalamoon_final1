import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../services/myTheme.dart';
import '../controller/change_password_controller.dart';
import '../widget/CustomTextField.dart';
import '../widget/confirm_dialog.dart';
import '../widget/custom_button.dart';

class ChangePassword extends StatelessWidget {

  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  WillPopScope(
        onWillPop: () async {
          return true;
        },
        child:  Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: AppStyle.getDeviceWidth(100, context),
                    height: AppStyle.getDeviceHeight(100, context) - (MediaQuery.of(context).padding.bottom + MediaQuery.of(context).padding.top),
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          App_Localization.of(context).translate('change_password'),
                          style: TextStyle(
                              color: Theme.of(context).dividerColor,
                              fontSize: 26
                          ),
                        ),
                        _inputTextField(context),
                        _buttons(context)
                      ],
                    ),

                  ),
                ),
                ConfirmDialog(
                    width: 70,
                    height: 200,
                    title: 'warning',
                    description: 'change_password_question',
                    button1Text: 'cancel',
                    button2Text: 'ok',
                    button1Pressed: (){
                      changePasswordController.showDialog.value = false;
                    },
                    button2Pressed: (){

                      changePasswordController.save(context);
                    },
                    openDialog: changePasswordController.loading.value ? false : changePasswordController.showDialog.value,
                    errorConfirm: false
                ),
                changePasswordController.loading.value
                    ? Container(
                  width: Get.width,
                  height: Get.height,
                     color: Theme.of(context).dividerColor.withOpacity(0.4),
                      child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : Text('')
              ],
            ),
          ) ,
        ),
      );
    });
  }

  _inputTextField(context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            width: 90,
            height: 7,
            controller: changePasswordController.newPassword,
            prefixIcon: const Icon(Icons.add, size: 0),
            suffixIcon: GestureDetector(
              onTap: (){
                changePasswordController.visibleOldPassword.value = !changePasswordController.visibleOldPassword.value;
              },
              child: changePasswordController.visibleOldPassword.value
                  ?  Icon(Icons.visibility_outlined, color: MyTheme.isDarkTheme.value ? Colors.white: AppStyle.grey)
                  :  Icon(Icons.visibility_off_outlined, color: MyTheme.isDarkTheme.value ? Colors.white: AppStyle.grey),
            ),
            labelText: App_Localization.of(context).translate('new_password'),
            hintText: App_Localization.of(context).translate('enter_your_new_password'),
            keyboardType: TextInputType.visiblePassword,
            textLength: 8,
            textFieldName: 'password',
            textVisible: changePasswordController.visibleOldPassword.value,
            maxLength: 4,
            isValidate: true,
            underlineColor: Theme.of(context).dividerColor,
            darkLightMode: true,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            width: 90,
            height: 7,
            controller: changePasswordController.confirmPassword,
            prefixIcon: const Icon(Icons.add, size: 0),
            suffixIcon: GestureDetector(
              onTap: (){
                changePasswordController.visibleNewPassword.value = !changePasswordController.visibleNewPassword.value;
              },
              child: changePasswordController.visibleNewPassword.value
                  ?  Icon(Icons.visibility_outlined, color: MyTheme.isDarkTheme.value ? Colors.white: AppStyle.grey)
                  :  Icon(Icons.visibility_off_outlined, color: MyTheme.isDarkTheme.value ? Colors.white: AppStyle.grey),
            ),
            labelText: App_Localization.of(context).translate('new_password'),
            hintText: App_Localization.of(context).translate('confirm_your_new_password'),
            keyboardType: TextInputType.visiblePassword,
            textLength: 8,
            textFieldName: 'password',
            textVisible: changePasswordController.visibleNewPassword.value,
            maxLength: 4,
            isValidate: true,
            underlineColor: Theme.of(context).dividerColor,
            darkLightMode: true,
          )
        ],
      ),
    );
  }

  _buttons(context){
    return Column(
      children: [
        CustomButton(
            width: 90,
            height: 7,
            text: App_Localization.of(context).translate('save'),
            onPressed: (){
              changePasswordController.checkChangePassword(context);
            },
            color: AppStyle.lightRed,
            color2: AppStyle.darkRed,
            borderRadius: 10,
            borderColor: Colors.white,
            borderWidth: 0,
            border: false,
            textStyle: CommonTextStyle.textStyleForBigButton),
        const SizedBox(height: 10),
        CustomButton(
            width: 90,
            height: 7,
            text: App_Localization.of(context).translate('back'),
            onPressed: (){
              Get.back();
            },
            color: Colors.grey,
            color2: Colors.grey,
            borderRadius: 10,
            borderColor: Colors.white,
            borderWidth: 0,
            border: false,
            textStyle: CommonTextStyle.textStyleForBigButton),
      ],
    );
  }

}
