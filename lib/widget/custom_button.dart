import 'package:flutter/material.dart';
import '../services/app_style.dart';

class CustomButton extends StatelessWidget {

  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color color2;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool border;
  final TextStyle textStyle;


  CustomButton({
      required this.width,
      required this.height,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.color2,
      required this.borderRadius,
      required this.borderColor,
      required this.borderWidth,
      required this.border,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppStyle.getDeviceWidth(width, context),
        height: AppStyle.getDeviceHeight(height, context),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                color,
                color2,
              ],
            ),
          border: border == true ? Border.all(width: borderWidth, color: borderColor) : null,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
              text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
