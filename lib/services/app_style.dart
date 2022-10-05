import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStyle{


  static Color lightRed = const Color(0XFFa40200);
  static Color darkRed = const Color(0XFF7f0604);
  static Color navyBlue = const Color(0XFF131d26);
  static Color grey = const Color(0XFF262c32);
  static Color red = const Color(0XFFc82b2b);


  static getDeviceWidth (percent, context){
    return MediaQuery.of(context).size.width * (percent / 100);
  }
  static getDeviceHeight (percent, context){
    return MediaQuery.of(context).size.height * (percent / 100);
  }


}

abstract class CommonTextStyle {

  static const tinyTextStyle = 12.0;
  static const smallTextStyle = 14.0;
  static const mediumTextStyle = 16.0;
  static const bigTextStyle = 18.0;
  static const largeTextStyle = 20.0;
  static const xlargeTextStyle = 22.0;
  static const xxlargeTextStyle = 26.0;

  static const String fontFamilyName = "Khebrat";

  static const textStyleForBigButton = TextStyle(
    fontFamily: fontFamilyName,
    fontSize: bigTextStyle,
    color: Colors.white,
  );

  static TextStyle textStyleForBigButton1 = TextStyle(
    fontFamily: fontFamilyName,
    fontSize: bigTextStyle,
    fontWeight: FontWeight.bold,
    color: AppStyle.lightRed,
  );

  static const textStyleForSmallButton = TextStyle(
    fontFamily: fontFamilyName,
    fontSize: smallTextStyle,
    color: Colors.white,
  );

  static defaultTextStyle(BuildContext context){
    return TextStyle(
        fontFamily: fontFamilyName,
        fontSize: smallTextStyle,
        color: Theme.of(context).dividerColor
    );
  }

  static titleTextStyle(BuildContext context){
    return TextStyle(
        fontFamily: fontFamilyName,
        fontSize: largeTextStyle,
        color: Theme.of(context).dividerColor,
        // fontWeight: FontWeight.bold
    );
}

  static selectionMenuTextStyle(BuildContext context){
    return TextStyle(
        fontFamily: fontFamilyName,
        fontSize: mediumTextStyle,
        color: Theme.of(context).dividerColor
    );
  }

  static const TextStyle settingsTextStyle = TextStyle(
      fontFamily: fontFamilyName,
      fontSize: bigTextStyle,
      color: Colors.white,//Theme.of(context).dividerColor,
    //MyTheme.isDarkTheme.value ? Colors.white : Colors.black
  );
  static settingsTextStyle1(BuildContext context){
    return TextStyle(
      fontFamily: fontFamilyName,
      fontSize: bigTextStyle,
      color: Theme.of(context).dividerColor,
    );
  }
  static settingsSmallTextStyle(BuildContext context){
    return TextStyle(
      fontFamily: fontFamilyName,
      fontSize: smallTextStyle,
      color: Theme.of(context).dividerColor,
    );
  }

  static Widget flightShuttleBuilder(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
      ) {
    return DefaultTextStyle(
      style: DefaultTextStyle
          .of(toHeroContext)
          .style,
      child: toHeroContext.widget,
    );
  }

}