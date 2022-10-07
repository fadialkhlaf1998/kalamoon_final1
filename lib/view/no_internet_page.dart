import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kalamoon_final/services/user_info.dart';
import 'package:kalamoon_final/view/qr_scanner.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../view/intro.dart';
import '../widget/custom_button.dart';

class NoInternetPage extends StatelessWidget {
  int id ;

  NoInternetPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: Get.width,
            height: 500,
            color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                UserInfo.id != "-1"
                    ?GestureDetector(
                  onTap: (){
                    Get.to(()=>QrScanner());
                  },
                  child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 10),
                  child: SvgPicture.asset(
                        'assets/icons/qr_code.svg',
                        color: Theme.of(context).dividerColor
                  ),
                ),
                    )
                    :Center(),
                SizedBox(height: 50,),

                Text(
                  App_Localization.of(context).translate('no_internet'),
                  textAlign: TextAlign.center,
                  style: CommonTextStyle.textStyleForBigButton1,
                ),
                Image.asset('assets/images/no_internet.png',width: Get.width * 0.8 ,fit: BoxFit.cover,),
                CustomButton(
                    width: 40,
                    height: 6,
                    text: App_Localization.of(context).translate('try_again'),
                    onPressed: (){
                      Get.back();
                    },
                    color: AppStyle.lightRed,
                    color2: AppStyle.darkRed,
                    borderRadius: 10,
                    borderColor: Colors.white,
                    borderWidth: 1,
                    border: false,
                    textStyle: CommonTextStyle.textStyleForBigButton
                ),


              ],
            )
          ),
        ),
      ),
    );
  }
}
