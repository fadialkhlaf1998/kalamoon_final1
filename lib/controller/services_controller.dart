

import 'dart:io';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesController extends GetxController{


  servicesRequest(String number) async {
    String message = "";
    if (Platform.isAndroid){
      // ignore: deprecated_member_use
      if(await canLaunch("https://wa.me/$number/?text=${Uri.parse(message)}")){
        // ignore: deprecated_member_use
        await launch("https://wa.me/$number/?text=${Uri.parse(message)}");
      }else{
        // App.error_msg(context, 'can\'t open Whatsapp');
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: number,
        );
        await launchUrl(launchUri);
      }
    }else if(Platform.isIOS){
      // ignore: deprecated_member_use
      if(await canLaunch("https://api.whatsapp.com/send?phone=$number=${Uri.parse(message)}")){
        // ignore: deprecated_member_use
        await launch("https://api.whatsapp.com/send?phone=$number=${Uri.parse(message)}");
      }else{
        // App.error_msg(context, 'can\'t open Whatsapp');
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: number,
        );
        await launchUrl(launchUri);
      }
    }
  }



}