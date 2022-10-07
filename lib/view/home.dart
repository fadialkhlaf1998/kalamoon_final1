import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/intro_conroller.dart';
import '../controller/login_controller.dart';
import '../services/user_info.dart';
import '../widget/logo_container.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../services/global.dart';
import '../controller/home_controller.dart';
import '../widget/custom_button.dart';
import '../widget/custom_choose_button.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class Home extends StatelessWidget {

  HomeController homeController = Get.find();
  IntroController introController = Get.find();
  LoginController loginController = Get.find();
  Home(){
    if(loginController.studentDay[0].meet.isEmpty){
      // homeController.goToSelectMode(context, 'station', 'selection2', introController.stationsList);
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        if(Global.langCode == "en"){
          Get.toNamed('/selectionMenu',arguments: ['station', 'selection2', introController.stationsList]);
        }else{
          Get.toNamed('/selectionMenu',arguments: ['الموقف المعتمد', 'selection2', introController.stationsList]);
        }

      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  width: AppStyle.getDeviceWidth(100, context),
                  height: AppStyle.getDeviceHeight(100, context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _header(context),
                      _busImage(context),
                      _daySelectionMenu(context),
                      /// todo
                      loginController.studentDay[homeController.selectDay.value].meet.isNotEmpty
                          ? loginController.studentDay[homeController.selectDay.value].meet.first.station.first.arrivalTime.isEmpty
                          ? const Text('')
                          : Text(App_Localization.of(context).translate("please_be_in")+loginController.studentDay[homeController.selectDay.value].meet.first.station.first.arrivalTime.first.hour,style: TextStyle(fontSize: 11),)
                          : const Text('') ,
                      // loginController.studentDay[homeController.selectDay.value].meet.first['station'].first['arrival_time'] != []
                      //     ? loginController.studentDay[homeController.selectDay.value].meet.first['begin_id'] != null
                      //     ? _expectedTimeText(context) : Text('') : Text(''),
                     // _deleteButton(context),
                      _chooseTimeAndStationMenu(context),
                      _saveButton(context),
                    ],
                  ),
                ),
                homeController.loading.value ?
                Container(
                  color: Theme.of(context).dividerColor.withOpacity(0.4),
                  width: AppStyle.getDeviceWidth(100, context),
                  height: AppStyle.getDeviceHeight(100, context),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ) : Text(''),
              ],
            )
        ),
      );
    });
  }


  _busImage(context){
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      width: AppStyle.getDeviceWidth(100, context),
      height: AppStyle.getDeviceHeight(homeController.editMode.value ? 0 : 20, context),
      child: Align(
        alignment: Alignment.center,
        child: LogoContainer(width: 100, height: 30),
        // child: Image.asset(
        //   'assets/images/bus_image.png',
        //   fit: BoxFit.contain,
        // ),
      )
    );
  }

  _header(context){
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: AppStyle.getDeviceWidth(90, context),
      // height: AppStyle.getDeviceHeight(7, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${App_Localization.of(context).translate('hello')}' + ' ' + UserInfo.name,
            style: CommonTextStyle.titleTextStyle(context),
          ),
          Text(
            '${App_Localization.of(context).translate('university_id')}' + ' ' + UserInfo.studentId,
            style: CommonTextStyle.defaultTextStyle(context),
          )
        ],
      )
    );
  }

  _daySelectionMenu(context){
    return Container(
      width: AppStyle.getDeviceWidth(90, context),
      height: AppStyle.getDeviceHeight(15, context),
      child: Column(
        children: [
          Divider(thickness: 1,color: Theme.of(context).dividerColor),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0),
            height: AppStyle.getDeviceHeight(10, context),
            child: ScrollablePositionedList.builder(
              itemScrollController: homeController.itemScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: introController.weekDayList.length,
              itemBuilder: (context, index){
                return Obx((){
                  return GestureDetector(
                    onTap: () async {
                      /// todo
                      /// Get the date of this day
                     if(homeController.editMode.value == false){
                       homeController.selectDay.value = index;
                       homeController.selectDayId.value = introController.weekDayList[index].id;
                       homeController.newBeginHourValue.value = '';
                       homeController.newEndHourValue.value = '';
                       homeController.newStationValue.value = '';
                     }else{
                       Get.snackbar(
                           App_Localization.of(context).translate("oops_wrong_happen"),
                           App_Localization.of(context).translate("please_save_changes_first"),
                           margin: const EdgeInsets.only(top: 20,left: 25,right: 25),
                           backgroundColor: AppStyle.red,
                           icon: const Icon(Icons.warning));
                     }
                      // if(Global.langCode == 'en'){
                      //   await homeController.scrollToItem(index);
                      //   }
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: AppStyle.getDeviceWidth(15, context),
                        decoration:BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                homeController.selectDay.value == index  ?  AppStyle.lightRed : Colors.transparent,
                                homeController.selectDay.value == index  ?  AppStyle.darkRed : Colors.transparent,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(
                            Global.langCode == 'en'
                                ? introController.weekDayList[index].title
                            : introController.weekDayList[index].ar_title,
                            style: TextStyle(
                                fontSize: CommonTextStyle.smallTextStyle,
                                fontWeight: FontWeight.bold,
                                color: homeController.selectDay.value == index ? Colors.white : Theme.of(context).dividerColor
                            ),
                          ),
                        )
                    ),
                  );
                });
              },
            ),
          ),
          Divider(thickness: 1,color: Theme.of(context).dividerColor,),
        ],
      ),
    );
  }

  _expectedTimeText(context){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: homeController.editMode.value ? 0 : 80,
      child: Center(
        child: Text(
         App_Localization.of(context).translate('expected_time') + ' '+ loginController.studentDay[homeController.selectDay.value].meet.first.station.first.arrivalTime.first.hour,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _chooseTimeAndStationMenu(context){
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      height: AppStyle.getDeviceHeight(25, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomChooseButton(
            tag: 'selection1',
            width: 90,
            height: 7,
            borderRadius: 10,
            image: 'to.svg',
            text: loginController.studentDay[homeController.selectDay.value].meet.isNotEmpty
                ? loginController.studentDay[homeController.selectDay.value].meet.first.beginHour != ''
                ? App_Localization.of(context).translate('to_university') + ' ' + '(${loginController.studentDay[homeController.selectDay.value].meet.first.beginHour})'
                : App_Localization.of(context).translate('to_university') + ' ' + App_Localization.of(context).translate('no_appointment')
                : App_Localization.of(context).translate('to_university'),
            newTimetext: homeController.newBeginHourValue.value,
            suffixIcon: homeController.editMode.value
                ? Icon(Icons.keyboard_arrow_down, size: 30)
                :  Icon(Icons.edit_calendar_outlined, size: 20),
            onTapIcon: (){
              homeController.goToSelectMode(context, 'to_university', 'selection1',introController.beginHourList);
            },
          ),
          CustomChooseButton(
            tag: 'selection',
            width: 90,
            height: 7,
            borderRadius: 10,
            image: 'from.svg',
            text: loginController.studentDay[homeController.selectDay.value].meet.isNotEmpty
                ? loginController.studentDay[homeController.selectDay.value].meet.first.endHour != ''
                ? App_Localization.of(context).translate('from_university') + ' ' + '(${loginController.studentDay[homeController.selectDay.value].meet.first.endHour})'
                : App_Localization.of(context).translate('from_university') + ' ' + App_Localization.of(context).translate('no_appointment')
                : App_Localization.of(context).translate('from_university'),
            newTimetext: homeController.newEndHourValue.value,
            suffixIcon: homeController.editMode.value
                        ? Icon(Icons.keyboard_arrow_down, size: 30)
                        :  Icon(Icons.edit_calendar_outlined, size: 20),
            onTapIcon: (){
              // print(introController.endHourList.last.hour);
              homeController.goToSelectMode(context, 'from_university', 'selection', introController.endHourList);
            },
          ),

          CustomChooseButton(
            tag: 'selection2',
            width: 90,
            height: 7,
            borderRadius: 10,
            image: 'station1.svg',
            text: loginController.studentDay[homeController.selectDay.value].meet.isNotEmpty
                ? App_Localization.of(context).translate('station') + ' ' + '(${loginController.studentDay[homeController.selectDay.value].meet.first.station.first.title})'
                : App_Localization.of(context).translate('station'),
            newTimetext: homeController.newStationValue.value,
            suffixIcon: Icon(Icons.edit_location_alt_outlined, size: 20),
            onTapIcon: (){
              // homeController.goToSelectMode(context, 'station', 'selection2', introController.stationsList);
            },
          ),
        ],
      ),
    );
  }

  _saveButton(context){
    return AnimatedContainer(
      height: AppStyle.getDeviceHeight(homeController.editMode.value ? 8 : 0, context),
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.only(bottom: homeController.editMode.value ? 30 : 0),
      child: SingleChildScrollView(
        child: CustomButton(
            width: 90,
            height: 7,
            text: App_Localization.of(context).translate('save'),
            onPressed: (){
              // homeController.editMode.value = false;
              homeController.saveCurrentOrNewMeet(context);
            },
            color: AppStyle.lightRed,
            color2: AppStyle.darkRed,
            borderRadius: 15,
            borderColor: Colors.white,
            borderWidth: 0,
            border: false,
            textStyle: CommonTextStyle.textStyleForBigButton
        ),
      ),
    );
  }

  _deleteButton(context){
    return AnimatedContainer(
      height: AppStyle.getDeviceHeight(homeController.editMode.value ? 8 : 0, context),
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.only(bottom: homeController.editMode.value ? 30 : 0),
      child: SingleChildScrollView(
        child: CustomButton(
            width: 50,
            height: 5,
            text: App_Localization.of(context).translate('delete_appointment'),
            onPressed: (){
              homeController.deleteMeetOperation();
            },
            color: AppStyle.lightRed,
            color2: AppStyle.darkRed,
            borderRadius: 20,
            borderColor: Colors.white,
            borderWidth: 1,
            border: false,
            textStyle: CommonTextStyle.textStyleForBigButton
        ),
      ),
    );
  }



}
