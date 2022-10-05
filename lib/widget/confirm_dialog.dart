import 'package:flutter/material.dart';
import '../app_localization.dart';
import '../services/app_style.dart';


class ConfirmDialog extends StatelessWidget {


  final double width;
  final double height;
  final String title;
  final String description;
  final String button1Text;
  final String button2Text;
  final VoidCallback button1Pressed;
  final VoidCallback button2Pressed;
  final bool openDialog;
  final bool errorConfirm;


  ConfirmDialog({
     required this.width,
     required this.height,
     required this.title,
     required this.description,
     required this.button1Text,
     required this.button2Text,
     required this.button1Pressed,
     required this.button2Pressed,
    required this.openDialog,
    required this.errorConfirm
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          child: openDialog ? AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            width: AppStyle.getDeviceWidth(100, context),
            height: AppStyle.getDeviceHeight(100, context),
            color: Theme.of(context).dividerColor.withOpacity(0.5),
          ) : Text(''),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
          width: AppStyle.getDeviceWidth(width, context),
          height: openDialog ? height : 0,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: errorConfirm ? AppStyle.red : Colors.transparent)
          ),
          child: SingleChildScrollView(
            child: Container(
              height: height - 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Text(
                      App_Localization.of(context).translate(title),
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: CommonTextStyle.bigTextStyle,
                          color: Theme.of(context).dividerColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20,right: 20, left: 20),
                    child: Text(
                      App_Localization.of(context).translate(description),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: CommonTextStyle.defaultTextStyle(context)
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: button1Pressed,
                        child: Container(
                          width: AppStyle.getDeviceWidth(34, context),
                          height: 40,
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                                App_Localization.of(context).translate(button1Text),
                              style: CommonTextStyle.defaultTextStyle(context)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: VerticalDivider(color: Theme.of(context).dividerColor.withOpacity(0.5),thickness: 1,width: 0,indent: 5,endIndent: 5,),
                      ),
                      GestureDetector(
                        onTap: button2Pressed,
                        child: Container(
                          width: AppStyle.getDeviceWidth(34, context),
                          height: 40,
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              App_Localization.of(context).translate(button2Text),
                                style: TextStyle(
                                  color: AppStyle.lightRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: CommonTextStyle.smallTextStyle
                                )
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
