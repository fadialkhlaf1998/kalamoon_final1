import 'package:flutter/material.dart';
import '../services/app_style.dart';

class BackgroundImage extends StatelessWidget {

  final String image;

  BackgroundImage({
    required this.image
});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidth(100, context),
      height: AppStyle.getDeviceHeight(100, context),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/$image')
        )
      ),
    );
  }
}
