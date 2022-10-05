import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/app_style.dart';

class CustomChooseButton extends StatelessWidget {

  final double width;
  final double height;
  final double borderRadius;
  final String image;
  final String text;
  final String newTimetext;
  final Widget suffixIcon;
  final VoidCallback onTapIcon;
  final String tag;



  CustomChooseButton({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.image,
    required this.text,
    required this.newTimetext,
    required this.suffixIcon,
    required this.onTapIcon,
    required this.tag
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      flightShuttleBuilder: CommonTextStyle.flightShuttleBuilder,
      tag: tag,
      child: GestureDetector(
        onTap: onTapIcon,
        child: Container(
          width: AppStyle.getDeviceWidth(width, context),
          height: AppStyle.getDeviceHeight(height, context),
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor, //MyTheme.isDarkTheme.value ? AppStyle.navyBlue : Colors.grey[300],
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    SizedBox(
                      width: AppStyle.getDeviceHeight(height - 3, context),
                      height: AppStyle.getDeviceHeight(height - 3, context),
                      child: SvgPicture.asset(
                        'assets/icons/$image',
                        fit: BoxFit.contain,
                        color: AppStyle.darkRed,
                      ),
                    ),
                    const SizedBox(width: 20),
                     newTimetext.isEmpty
                         ? Container(
                             width: AppStyle.getDeviceWidth(48, context),
                             child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  color: Theme.of(context).dividerColor
                              ),
                          ),
                     )
                         : Text(''),
                    const SizedBox(width: 10),
                    Text(
                      newTimetext,
                      style: TextStyle(
                          fontSize: CommonTextStyle.smallTextStyle,
                          fontWeight: FontWeight.bold,
                          color: AppStyle.lightRed,//Theme.of(context).dividerColor
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: suffixIcon,
              )
            ],
          ),
        ),
      ),
    );
  }
}
