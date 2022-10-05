

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

  TextEditingController name = TextEditingController();
  TextEditingController studentId = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool visiblePassword = true.obs;

}