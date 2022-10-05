import 'package:flutter/material.dart';
import '../services/app_style.dart';
import '../services/myTheme.dart';

class CustomTextField extends StatefulWidget {

  final double width;
  final double height;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final int textLength;
  final String textFieldName;
  final bool textVisible;
  final int maxLength;
  final bool isValidate;
  final Color underlineColor;
  final bool darkLightMode;

  CustomTextField({
      required this.width,
      required this.height,
      required this.controller,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.labelText,
      required this.hintText,
      required this.keyboardType,
      required this.textLength,
    required this.textFieldName,
    required this.textVisible,
    required this.maxLength,
    required this.isValidate,
    required this.underlineColor,
    required this.darkLightMode
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            ),
          ),
        SizedBox(
          width: AppStyle.getDeviceWidth(widget.width, context),
          //height: AppStyle.getDeviceHeight(5, context),
          child: TextFormField(
            style: TextStyle(
              color: widget.darkLightMode ? MyTheme.isDarkTheme.value ?  Colors.white : AppStyle.darkRed : Colors.white,
            ),
            controller: widget.controller,
            validator: (text) {
              if(widget.isValidate){
                if (text!.isEmpty) {
                  setState(() {
                    check = false;
                  });
                  return 'This field cannot be empty';
                } else if (text.length < widget.textLength) {
                  setState(() {
                    check = false;
                  });
                  return widget.textFieldName == 'ID'
                      ? '${widget.textFieldName} must be ${widget.textLength} long'
                      : '${widget.textFieldName} must be at least ${widget.textLength} characters long';
                }
                setState(() {
                  check = true;
                });
              }
              return null;
            },
            obscureText: widget.textVisible,
            decoration:  InputDecoration(
              counterText: "",
              errorStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
              //prefixIcon: prefixIcon,
              suffixIcon: check
                  ? Container(
                width: 1,
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/checked.png')
                  )
                ),
              )
                  : widget.suffixIcon,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: AppStyle.lightRed),
              ),
              enabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: widget.underlineColor)),
              hintText: widget.hintText,
              hintStyle:
              TextStyle(
                  color: widget.darkLightMode ? MyTheme.isDarkTheme.value ?  Colors.white : AppStyle.grey : Colors.white,
                  fontSize: 14
              ),
            ),
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,

          ),
        ),
      ],
    );
  }
}
