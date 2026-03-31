import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/features/signin/presentation/views/signin_screen.dart';
import 'package:art_of_pilates/app/features/signup/presentation/views/signup_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signinScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
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
