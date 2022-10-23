
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kalamoon_final/app_localization.dart';
import 'package:kalamoon_final/controller/services_controller.dart';
import 'package:kalamoon_final/services/app_style.dart';
import 'package:kalamoon_final/services/messages.dart';
import 'package:kalamoon_final/services/user_info.dart';
import 'package:kalamoon_final/widget/services_widget.dart';

class ServicesPage extends StatelessWidget {

  ServicesController servicesController = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Stack(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  _title(context),
                  _menu(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  _title(context){
    return Container(
      width: AppStyle.getDeviceWidth(100, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/services.svg',
            width: AppStyle.getDeviceWidth(10, context),
            height: AppStyle.getDeviceWidth(10, context),
            color: Theme.of(context).dividerColor,
          ),
          const SizedBox(width: 10),
          Text(
            App_Localization.of(context).translate('services'),
            style: TextStyle(
                color: Theme.of(context).dividerColor,
                fontSize: 26,
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }

  _menu(context){
    return Container(
      width: AppStyle.getDeviceWidth(90, context),
      height: AppStyle.getDeviceHeight(70, context),
      child: Column(
        children: [
          ServicesWidget(
              height: 10,
              text: 'printing_service',
              onTap: (){
                servicesController.servicesRequest('+963991031308',Messages.printServices(UserInfo.name, UserInfo.studentId));
              }
          ),
          ServicesWidget(
              height: 10,
              text: 'bill_payment_service',
              onTap: (){
                servicesController.servicesRequest('+963968304530',Messages.payPillServices(UserInfo.name, UserInfo.studentId));
              }
          ),
          ServicesWidget(
              height: 10,
              text: 'exam_session_service',
              onTap: (){
                servicesController.servicesRequest('+963934481988',Messages.examSessionServices(UserInfo.name, UserInfo.studentId));
              }
          ),
        ],
      ),
    );
  }
}
