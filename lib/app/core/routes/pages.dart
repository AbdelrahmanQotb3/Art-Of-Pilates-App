import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/views/all_bookings_screen.dart';
import 'package:art_of_pilates/app/features/get_started/get_started_screen.dart';
import 'package:art_of_pilates/app/features/home/presentation/home_screen.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/package_checkout_screen.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/package_details_screen.dart';
import 'package:art_of_pilates/app/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:art_of_pilates/app/features/profile/presentation/views/profile_screen.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/payment/presentation/views/payment_screen.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/views/session_checkout_screen.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/views/session_details_screen.dart';
import 'package:art_of_pilates/app/features/services/presentation/views/service_details_screen.dart';
import 'package:art_of_pilates/app/features/services/presentation/views/services_screen.dart';
import 'package:art_of_pilates/app/features/settings/presentation/views/about/about_app_screen.dart';
import 'package:art_of_pilates/app/features/settings/presentation/views/about/privacy_and_policy_screen.dart';
import 'package:art_of_pilates/app/features/settings/presentation/views/about/terms_and_conditions_screen.dart';
import 'package:art_of_pilates/app/features/settings/presentation/views/delete_account_screen.dart';
import 'package:art_of_pilates/app/features/settings/presentation/views/languages_screen.dart';
import 'package:art_of_pilates/app/features/settings/presentation/views/notifications_screen.dart';
import 'package:art_of_pilates/app/features/settings/presentation/views/settings_screen.dart';
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
        final args = settings.arguments;
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(initialIndex: args),
          );
        }
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
      case Routes.packageDetailsScreen:
        final args = settings.arguments;
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => PackageDetailsScreen(packageId: args),
          );
        }
        return unDefinedRoute();
      case Routes.packageCheckoutScreen:
        final args = settings.arguments;
        if (args is PricingPlanEntity) {
          return MaterialPageRoute(
            builder: (_) => PackageCheckoutScreen(plan: args),
          );
        }
        return unDefinedRoute();
      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case Routes.languageScreen:
        return MaterialPageRoute(builder: (_) => LanguagesScreen());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      case Routes.aboutAppScreen:
        return MaterialPageRoute(builder: (_) => AboutAppScreen());
      case Routes.deleteAccountScreen:
        return MaterialPageRoute(builder: (_) => DeleteAccountScreen());
      case Routes.allBookingsScreen:
        return MaterialPageRoute(builder: (_) => AllBookingsScreen());
      case Routes.sessionCheckoutScreen:
        final args = settings.arguments;
        if (args is SessionEntity) {
          return MaterialPageRoute(
            builder: (_) => SessionCheckoutScreen(session: args),
          );
        }
        return unDefinedRoute();
      case Routes.paymentScreen:
        final args = settings.arguments;
        if (args is SessionEntity) {
          return MaterialPageRoute(
            builder: (_) => PaymentScreen(session: args),
          );
        } else if (args is PricingPlanEntity) {
          return MaterialPageRoute(builder: (_) => PaymentScreen(plan: args));
        }
        return unDefinedRoute();
      case Routes.termsAndConditionsScreen:
        return MaterialPageRoute(builder: (_) => TermsAndConditionsScreen());
      case Routes.privacyPolicyScreen:
        return MaterialPageRoute(builder: (_) => PrivacyAndPolicyScreen());
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
