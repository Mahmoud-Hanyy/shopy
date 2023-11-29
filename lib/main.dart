import 'package:flutter/material.dart';
import 'package:shopy/modules/onBoarding/onboarding_screen.dart';
import 'package:shopy/modules/shop_layout/layout_screen.dart';
import 'package:shopy/modules/shop_login/login.dart';
import 'package:shopy/network/local/cache_helper.dart';
import 'package:shopy/network/remote/dio_helper.dart';
import 'package:shopy/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // sure that methods will be called before runApp
  DioHelper.init();
  await CacheHelper.init();

  Widget widget ;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');

  if(onBoarding != null){
    if(token != null){
      widget = ShopLayout();
    }else{
      widget = ShopLogInScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }


  runApp(MyApp( startWidget: widget,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget, });
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
    }
}