import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/features/get_started/get_started_screen.dart';
import 'package:art_of_pilates/app/features/home/presentation/home_screen.dart';
import 'package:art_of_pilates/app/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:art_of_pilates/app/features/profile/presentation/views/profile_screen.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/views/session_details_screen.dart';
import 'package:art_of_pilates/app/features/services/presentation/views/service_details_screen.dart';
import 'package:art_of_pilates/app/features/services/presentation/views/services_screen.dart';
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
      case Routes.serviceDetailsScreen:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ServiceDetailsScreen(serviceId: args),
          );
        }
        return unDefinedRoute();
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.editProfileScreen:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case Routes.sessionDetailsScreen:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SessionDetailsScreen(sessionId: args),
          );
        }
        return unDefinedRoute();
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
