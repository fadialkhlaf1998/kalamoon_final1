

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import 'package:url_launcher/url_launcher.dart';

class NotActivationController extends GetxController{

  whatsapp(context) async {
    String message = "";
    String number = '0934481988';
    if (Platform.isAndroid){
      if(await canLaunch("https://wa.me/${number}/?text=${Uri.parse(message)}")){
        await launch("https://wa.me/${number}/?text=${Uri.parse(message)}");
      }else{
        Get.snackbar(
          App_Localization.of(context).translate('error'),
          App_Localization.of(context).translate('cannot_open_whatsapp'),
          margin: EdgeInsets.only(top: 20,left: 25,right: 25),
          backgroundColor: AppStyle.red,
          icon: Icon(Icons.warning),
        );
      }
    }else if(Platform.isIOS){
      if(await canLaunch("https://api.whatsapp.com/send?phone=${number}=${Uri.parse(message)}")){
        await launch("https://api.whatsapp.com/send?phone=${number}=${Uri.parse(message)}");
      }else{
        Get.snackbar(
          App_Localization.of(context).translate('error'),
          App_Localization.of(context).translate('cannot_open_whatsapp'),
          margin: EdgeInsets.only(top: 20,left: 25,right: 25),
          backgroundColor: AppStyle.red,
          icon: Icon(Icons.warning),
        );
      }
    }
  }

  phone() async {
    String number = '0934481988';
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(launchUri);
  }

}