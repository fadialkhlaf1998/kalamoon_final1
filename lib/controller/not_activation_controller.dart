import 'dart:io';
import 'package:get/get.dart';
import '../services/app_style.dart';
import 'package:url_launcher/url_launcher.dart';

class NotActivationController extends GetxController{

  whatsapp(context) async {
    String message = "";
    String number = '0934481988';
    if (Platform.isAndroid){
      // ignore: deprecated_member_use
      if(await canLaunch("https://wa.me/$number/?text=${Uri.parse(message)}")){
        // ignore: deprecated_member_use
        await launch("https://wa.me/$number/?text=${Uri.parse(message)}");
      }else{
        AppStyle.errorNotification(context, 'error', 'cannot_open_whatsapp');
      }
    }else if(Platform.isIOS){
      // ignore: deprecated_member_use
      if(await canLaunch("https://api.whatsapp.com/send?phone=$number=${Uri.parse(message)}")){
        // ignore: deprecated_member_use
        await launch("https://api.whatsapp.com/send?phone=$number=${Uri.parse(message)}");
      }else{
        AppStyle.errorNotification(context, 'error', 'cannot_open_whatsapp');
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