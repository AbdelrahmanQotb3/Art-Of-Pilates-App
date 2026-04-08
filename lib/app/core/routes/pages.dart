import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/features/get_started/get_started_screen.dart';
import 'package:art_of_pilates/app/features/home/presentation/home_screen.dart';
import 'package:art_of_pilates/app/features/services/views/services_screen.dart';
import 'package:art_of_pilates/app/features/signin/presentation/views/signin_screen.dart';
import 'package:art_of_pilates/app/features/signup/presentation/views/signup_screen.dart';
import 'package:art_of_pilates/app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.getStartedScreen:
        return MaterialPageRoute(builder: (_) => GetStartedScreen());
      case Routes.signinScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.servicesScreen:
        return MaterialPageRoute(builder: (_) => ServicesScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: Center(child: Text('No Route Found')),
      ),
    );
  }
}
