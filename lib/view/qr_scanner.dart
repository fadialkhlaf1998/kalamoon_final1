import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/encryption.dart';
import '../services/user_info.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScanner extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          width: AppStyle.getDeviceWidth(100, context),
          height: AppStyle.getDeviceHeight(100, context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/qr_code.svg', width: 25,height: 25,color: Theme.of(context).dividerColor,),
                    const SizedBox(width: 15),
                    Text(
                    App_Localization.of(context).translate('scan_the_qr_code'),
                    style: CommonTextStyle.settingsTextStyle1(context),)
                  ],
                ),
                const SizedBox(height: 50),
                QrImage(
                  data: EncryptData.encryptAES(UserInfo.id),
                  backgroundColor: Colors.white,
                  version: QrVersions.auto,
                  size: 250,
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
