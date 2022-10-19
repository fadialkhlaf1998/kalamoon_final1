import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_localization.dart';
import '../../services/api.dart';
import '../../services/app_style.dart';
import '../../services/encryption.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainPageAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
              Get.offAllNamed('/welcome');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'اضغط لمسح الكود',
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontSize: 18
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QRViewExample(),
                    ));
                  },
                  child: Icon(Icons.qr_code, size: 60),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class QRViewExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');



  @override
  void initState() {
    super.initState();
    // controller
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 10),
                result != null
                    ? Text('Data: ${EncryptData.decryptAES(result!.code)}', style: TextStyle(fontSize: 18),)
                    : const Text('Scan a code'),
                  Container(
                    margin: const EdgeInsets.all(0),
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            return Text('Flash: ${snapshot.data}');
                          },
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(0),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.all(0),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.pauseCamera();
                      //     },
                      //     child: const Text('pause',
                      //         style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {

    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        String id = EncryptData.decryptAES(scanData.code);
        controller.pauseCamera();
        Api.checkInternet().then((value){
          if(value){
            Api.checkIn(id).then((value) async {
              if(value){
                Get.snackbar(
                    App_Localization.of(context).translate('successfully'),
                    App_Localization.of(context).translate('successfully_registered'),
                    margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.check)
                );
                print('--------------true');
              }else{
                Get.snackbar(
                  App_Localization.of(context).translate('error'),
                  App_Localization.of(context).translate('wrong'),
                  margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
                  backgroundColor: AppStyle.red,
                  icon: const Icon(Icons.warning),
                );
                print('--------------false');
              }
            });
          }else{
            print('no internet');
            Get.snackbar(
                App_Localization.of(context).translate('no_internet_msg'),
                App_Localization.of(context).translate('no_internet_msg_desc'),
          margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
          backgroundColor: AppStyle.red,
          icon: const Icon(Icons.warning));

          }
        });
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

