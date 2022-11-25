import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proteanmobileapp/architecture/mvvm/utils/routes/routes_name.dart';
import 'package:proteanmobileapp/architecture/mvvm/view/home_screen.dart';
import 'package:proteanmobileapp/architecture/mvvm/view/login_screen.dart';
import 'package:proteanmobileapp/architecture/mvvm/view/signp_screen.dart';
import 'package:proteanmobileapp/architecture/mvvm/view/splash_screen.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());

      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}