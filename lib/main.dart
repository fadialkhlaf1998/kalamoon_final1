import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import '../view/no_internet_page.dart';
import '../view/sub_admin/main_page.dart';
import '../app_localization.dart';
import '../services/app_style.dart';
import '../services/global.dart';
import '../services/myTheme.dart';
import '../services/store.dart';
import '../view/change_language.dart';
import '../view/change_password.dart';
import '../view/intro.dart';
import '../view/login.dart';
import '../view/selectio_menu.dart';
import '../view/sign_up.dart';
import '../view/welcome.dart';
import '../view/main_page.dart';

void main() {
  runApp( MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppStyle.grey, //MyTheme.isDarkTheme.value ? A : Colors.blue,
  ));
}

class MyApp extends StatefulWidget {

  static void set_local(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  static void setTheme(BuildContext context){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setDark();
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;
  Rx<MyTheme> myTheme = MyTheme().obs;

  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  void setDark(){
    setState(() {
      myTheme.value.myTheme;
    });
  }

  @override
  void initState(){
    Store.loadTheme().then((value) {
      MyTheme.isDarkTheme.value = value;
    });

    // set_locale(Locale('ar'));
    Get.updateLocale(Locale('ar'));
    setState(() {
      _locale = Locale('ar');
    });
    // Global.loadLanguage().then((language) {
    //   setState(() {
    //     _locale= Locale(language);
    //   });
    // });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        getPages: [
          GetPage(
            name: '/welcome',
            page: ()=> Welcome(),
            transition: Transition.fadeIn, transitionDuration: const Duration(milliseconds: 800), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/language',
            page: ()=> ChangeLanguage(),
            transition: Transition.fadeIn, transitionDuration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/login',
            page: ()=> Login(),
            transition: Transition.fadeIn, transitionDuration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/signUp',
            page: ()=> SignUp(),
            transition: Transition.fadeIn, transitionDuration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/mainPage',
            page: ()=> MainPage(),
            transition: Transition.fadeIn, transitionDuration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/selectionMenu',
            page: ()=> SelectionMenu(),
            transition: Transition.leftToRight,transitionDuration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/changePassword',
            page: ()=> ChangePassword(),
            transition: Transition.fadeIn,transitionDuration: const Duration(milliseconds: 400), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/mainPageAdmin',
            page: ()=> MainPageAdmin(),
            transition: Transition.fadeIn,transitionDuration: const Duration(milliseconds: 400), curve: Curves.fastOutSlowIn,
          ),
          GetPage(
            name: '/noInternet',
            page: ()=> NoInternetPage(),
            transition: Transition.fadeIn,transitionDuration: const Duration(milliseconds: 400), curve: Curves.fastOutSlowIn,
          ),
        ],
        debugShowCheckedModeBanner: false,
        themeMode: myTheme.value.myTheme,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        locale: _locale,
        supportedLocales: [ Locale('ar', '')],
        localizationsDelegates: const [
          App_Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (local, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == local!.languageCode) {
              Global.langCode = supportedLocale.languageCode;
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: Intro()
    );
  }
}
