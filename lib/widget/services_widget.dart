import 'package:flutter/material.dart';
import 'package:kalamoon_final/app_localization.dart';
import 'package:kalamoon_final/services/app_style.dart';

class ServicesWidget extends StatelessWidget {

  double height;
  String text;
  VoidCallback onTap;


  ServicesWidget({
    required this.height,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: AppStyle.getDeviceHeight(height, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              App_Localization.of(context).translate(text),
              style: CommonTextStyle.servicesTextStyle(context),
            ),
            Icon(Icons.arrow_forward_ios, size: 20,color: Theme.of(context).dividerColor)
          ],
        ),
      ),
    );
  }
}
