import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
        onWillPop: ()async {
          return mainPageController.backButton(context, homeController);
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavyBar(
            containerHeight: AppStyle.getDeviceHeight(8, context),
            backgroundColor: AppStyle.lightRed,
            selectedIndex: mainPageController.selectedIndex.value,
            showElevation: true,
            onItemSelected: (index) {
              mainPageController.selectedIndex.value = index;
              mainPageController.pageController.animateToPage(index, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
              // mainPageController.pageController.jumpTo(index*MediaQuery.of(context).size.width);
            },
            items: [
              BottomNavyBarItem(
                  icon: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(left: 10),
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
                    margin: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                        'assets/icons/qr_code.svg',
                        color: Colors.white
                    ),
                  ),
                  title: Text(
                    'QR',
                    style: TextStyle(
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
                    margin: const EdgeInsets.only(left: 10),
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
                onPageChanged: (index){
                  //  print(index);
                  mainPageController.selectedIndex.value = index;
                },
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  Home(),
                  QrScanner(),
                  Settings()
                ],
              )
          ),
        ),
      );
    });
  }
}
