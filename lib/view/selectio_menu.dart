import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../services/global.dart';
import '../services/myTheme.dart';
import '../controller/selection_menu_controller.dart';
import '../widget/custom_button.dart';

class SelectionMenu extends StatelessWidget {

  SelectionMenuController selectionMenuController = Get.put(SelectionMenuController());
  HomeController homeController = Get.find();

  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: AppStyle.getDeviceWidth(100, context),
          height: AppStyle.getDeviceHeight(100, context) - MediaQuery.of(context).padding.bottom,
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppStyle.getDeviceWidth(90, context),
                height: AppStyle.getDeviceHeight(7, context),
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft:  Radius.circular(10),
                  ),
                ),
                child: Center(
                    child: Text(
                        data[0],
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontSize: 14
                      ),
                    )
                ),
              ),
              _menu(context),
              const SizedBox(height: 25),
              CustomButton(
                  width: 90,
                  height: 7,
                  text: App_Localization.of(context).translate('choose'),
                  onPressed: (){
                    if(data[1] == 'selection1'){
                      if(homeController.newBeginHourValue.isNotEmpty){
                        Get.back();
                      }
                    }else if(data[1] == 'selection'){
                      if(homeController.newEndHourValue.isNotEmpty){
                        Get.back();
                      }
                    }else if(data[1] == 'selection2'){
                        Get.back();
                    }
                  },
                  color: AppStyle.lightRed,
                  color2: AppStyle.darkRed,
                  borderRadius: 10,
                  borderColor: Colors.white,
                  borderWidth: 0,
                  border: false,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Khebrat',
                    fontWeight: FontWeight.normal,
                    fontSize: CommonTextStyle.bigTextStyle,
                  )
              ),
              // const SizedBox(height: 10),
              // CustomButton(
              //     width: 90,
              //     height: 7,
              //     text: App_Localization.of(context).translate('back'),
              //     onPressed: (){
              //       if(data[1] == 'selection1'){
              //         if(homeController.newBeginHourValue.isNotEmpty){
              //           Get.back();
              //         }
              //       }else if(data[1] == 'selection'){
              //         if(homeController.newEndHourValue.isNotEmpty){
              //           Get.back();
              //         }
              //       }
              //       Get.back();
              //     },
              //     color: Theme.of(context).disabledColor,
              //     color2:Theme.of(context).disabledColor,
              //     borderRadius: 10,
              //     borderColor: Colors.white,
              //     borderWidth: 0,
              //     border: false,
              //     textStyle: TextStyle(
              //         color: MyTheme.isDarkTheme.value ? Colors.white : Colors.grey,
              //       fontFamily: 'Muli',
              //       fontWeight: FontWeight.bold,
              //       fontSize: CommonTextStyle.bigTextStyle,
              //     )
              // ),
              const SizedBox(height: 10),
              data[1] == 'selection2'
                  ? const Text('')
                  : CustomButton(
                  width: 90,
                  height: 7,
                  text: data[1] == "selection1" ?  App_Localization.of(context).translate('cancel_appointment') :  App_Localization.of(context).translate('cancel_appointment2'),
                  onPressed: (){
                    if(data[1] == 'selection1'){
                      homeController.newBeginHourValue.value = App_Localization.of(context).translate('cancel_appointment');
                      homeController.selectIndexForBeginHour.value = -1;
                      homeController.cancelBeginHour.value = true;
                      Get.back();
                    }else if(data[1] == 'selection'){
                     homeController.newEndHourValue.value = App_Localization.of(context).translate('cancel_appointment');
                     homeController.selectIndexForEndHour.value = -1;
                     homeController.cancelEndHour.value = true;
                        Get.back();
                      }
                  },
                  color: Theme.of(context).disabledColor,
                  color2: Theme.of(context).disabledColor,
                  borderRadius: 10,
                  borderColor: Colors.white,
                  borderWidth: 0,
                  border: false,
                  textStyle: TextStyle(
                    color: MyTheme.isDarkTheme.value ? Colors.white : AppStyle.red,
                    fontFamily: 'Khebrat',
                    fontWeight: FontWeight.normal,
                    fontSize: CommonTextStyle.bigTextStyle,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  _menu(context){
    return Container(
      width: AppStyle.getDeviceWidth(90, context),
      height: AppStyle.getDeviceHeight(45, context),
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft:  Radius.circular(10),
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: data[2].length,
        itemBuilder: (context, index){
          return data[1] == 'selection2'
              ? Obx((){
                return GestureDetector(
                  onTap: (){
                    selectionMenuController.selectIndex.value = index;
                    homeController.selectIndexForStation.value = index;
                    homeController.newStationValue.value = data[2][index].title;
                    },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6,top: 6, right: 10, left: 10),
                        width: AppStyle.getDeviceWidth(90, context),
                        height: AppStyle.getDeviceHeight(12, context),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      selectionMenuController.selectIndex.value == index
                          ? Container(
                          margin: const EdgeInsets.only(bottom: 6, top: 6,right: 10,left: 10),
                          width: AppStyle.getDeviceWidth(90, context),
                          height: AppStyle.getDeviceHeight(12, context),
                          decoration: BoxDecoration(
                              color: AppStyle.lightRed.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: AppStyle.lightRed)
                          )
                      )
                          : Text(''),
                      Container(
                        margin: const EdgeInsets.only(bottom: 6,top: 6, right: 10, left: 10),
                        width: AppStyle.getDeviceWidth(90, context),
                        height: AppStyle.getDeviceHeight(12, context),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: AppStyle.getDeviceWidth(25, context),
                              height: AppStyle.getDeviceHeight(12, context),
                              decoration: BoxDecoration(
                                  borderRadius: Global.langCode == 'en'
                                      ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)
                                  )
                                      :  const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10)
                                  ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data[2][index].image)
                                )
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: AppStyle.getDeviceWidth(55, context),
                              height: AppStyle.getDeviceHeight(12, context),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[2][index].title,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).dividerColor,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data[2][index].description,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
          })
                  : Obx((){
                    return GestureDetector(
                      onTap: (){
                        selectionMenuController.selectIndex.value = index;
                        if(data[1] == 'selection'){
                          homeController.selectIndexForEndHour.value = index;
                          homeController.newEndHourValue.value = data[2][index].hour;
                        }else if(data[1] == 'selection1'){
                          homeController.selectIndexForBeginHour.value = index;
                          homeController.newBeginHourValue.value = data[2][index].hour;

                        }
                        // print('-----------------------------');
                        // print( homeController.selectIndexForEndHour.value);
                        // print( homeController.selectIndexForBeginHour.value);
                        // print('-----------------------------');
                        },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 4,top: 4),
                            width: AppStyle.getDeviceWidth(90, context),
                            height: AppStyle.getDeviceHeight(7, context),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          data[1] == 'selection1'
                              ? selectionMenuController.selectIndex.value == index
                              ? Container(
                              margin: const EdgeInsets.only(bottom: 4,right: 10,left: 10),
                              width: AppStyle.getDeviceWidth(90, context),
                              height: AppStyle.getDeviceHeight(7, context),
                              decoration: BoxDecoration(
                                  color: AppStyle.lightRed.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: AppStyle.lightRed)
                              )
                          ) : Text('')
                          : selectionMenuController.selectIndex.value == index
                              ? Container(
                              margin: const EdgeInsets.only(bottom: 4,right: 10,left: 10),
                              width: AppStyle.getDeviceWidth(90, context),
                              height: AppStyle.getDeviceHeight(7, context),
                              decoration: BoxDecoration(
                                  color: AppStyle.lightRed.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: AppStyle.lightRed)
                              )
                          ) : Text(''),
                          Text(
                            data[2][index].hour,
                            style: CommonTextStyle.selectionMenuTextStyle(context),
                          )
                        ],
                      ),
                    );
                  }) ;
        },
      ),
    );
  }


}
