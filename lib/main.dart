import 'package:first_project/layouts/ShopApp/shop_layout.dart';
import 'package:first_project/moduels/shop_app/login/shop_login_screen.dart';
import 'package:first_project/moduels/shop_app/onBoarding/on_boarding_screen.dart';
import 'package:first_project/shared/network/local/cache_helper.dart';
import 'package:first_project/shared/network/remote/dio_helper.dart';
import 'package:first_project/shared/network/styles/themes.dart';
import 'package:flutter/material.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized(); 
  DioHelper.init();
  await CacheHelper.init();
  bool? onboarding = CacheHelper.getData(key: 'OnBoarding');
  String? token = CacheHelper.getData(key: 'token');
  Widget widget ;
  if(onboarding != null){
    if(token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }
  else {
    widget = OnBoardingScreen();
  }
  //Bloc.observer = MyBlocObserver();
  runApp(Myapp(widget));
}

class Myapp extends StatelessWidget{
  final Widget startWidget ;
  Myapp(this.startWidget);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,
      //home: onboarding == true ? ShopLoginScreen() : OnBoardingScreen(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light

    );

  }

}



