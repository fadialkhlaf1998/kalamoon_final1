import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/app_style.dart';
import '../controller/intro_conroller.dart';
import '../widget/logo_container.dart';

class Intro extends StatelessWidget {

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppStyle.getDeviceWidth(100, context),
        color: AppStyle.grey,
        child: const Center(
          child: Hero(
            tag: 'introLogo',
            child: LogoContainer(
              height: 20,
              width: 40,
            ),
          ),
        )
      )
    );
  }
}
