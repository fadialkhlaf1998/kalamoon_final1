import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kalamoon_final/view/services.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../controller/home_controller.dart';
import '../controller/main_page_controller.dart';
import '../view/home.dart';
import '../view/qr_scanner.dart';
import '../view/settings.dart';

class MainPage extends StatelessWidget {

  MainPageController mainPageController = Get.put(MainPageController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return WillPopScope(
        onWillPop: () async {
          return mainPageController.backButton(context, homeController);
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavyBar(
            containerHeight: 55,//AppStyle.getDeviceHeight(6, context),
            backgroundColor: AppStyle.lightRed,
            selectedIndex: mainPageController.selectedIndex.value,
            showElevation: true,
            onItemSelected: (index) {
              if(homeController.editMode.value){
                AppStyle.errorNotification(context, "oops_wrong_happen", "oops_wrong_happen");
              }else{
                mainPageController.selectedIndex.value = index;
                mainPageController.pageController.animateToPage(index, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
              }
              // mainPageController.pageController.jumpTo(index*MediaQuery.of(context).size.width);
            },
            items: [
              BottomNavyBarItem(
                  icon: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(left: 5,right: 5),
                    child: SvgPicture.asset(
                        'assets/icons/home.svg',
                        color: Colors.white
                    ),
                  ),
                  title: Text(
                    App_Localization.of(context).translate("home"),
                    style: const TextStyle(
                        color: Colors.white
                    ),
                  ),
                  activeColor: Colors.white,
                  textAlign: TextAlign.center
              ),
              BottomNavyBarItem(
                  icon: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(left: 5,right: 5),
                    child: SvgPicture.asset(
                        'assets/icons/qr_code.svg',
                        color: Colors.white
                    ),
                  ),
                  title: const Text(
                    'QR',
                    style: TextStyle(
                      fontFamily: 'Muli',
                        color: Colors.white
                    ),
                  ),
                  activeColor: Colors.white,
                  textAlign: TextAlign.center
              ),
              BottomNavyBarItem(
                  icon: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(left: 5,right: 5),
                    child: SvgPicture.asset(
                        'assets/icons/services.svg',
                        color: Colors.white
                    ),
                  ),
                  title: Text(
                    App_Localization.of(context).translate('services'),
                    style: const TextStyle(
                        fontFamily: 'Muli',
                        color: Colors.white
                    ),
                  ),
                  activeColor: Colors.white,
                  textAlign: TextAlign.center
              ),
              BottomNavyBarItem(
                  icon: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(left: 5,right: 5),
                    child: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    App_Localization.of(context).translate("settings"),
                    style: const TextStyle(
                        color: Colors.white
                    ),
                  ),
                  activeColor: Colors.white,
                  textAlign: TextAlign.center

              ),
            ],
          ),
          body: SafeArea(
              child: PageView(
                controller: mainPageController.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) async {
                  // mainPageController.pageController.jumpTo(index*MediaQuery.of(context).size.width);
                  // await Future.delayed(Duration(milliseconds: 1500)).then((value){
                  //   mainPageController.selectedIndex.value = index;
                  // });
                },
                children: [
                  Home(),
                  QrScanner(),
                  ServicesPage(),
                  Settings()
                ],
              )
          ),
        ),
      );
    });
  }
}
