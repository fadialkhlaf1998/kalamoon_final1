import 'package:flutter/material.dart';
import '../services/app_style.dart';

class LogoContainer extends StatelessWidget {

  final double width;
  final double height;

  const LogoContainer({
    required this.width,
    required this.height
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidth(width, context),
      height: AppStyle.getDeviceHeight(height, context),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/icons/logo.png')
        )
      ),
    );
  }
}
