import 'package:art_of_pilates/app/features/home/domain/use_cases/launch_social_url_use_case.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_events.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_states.dart';
import 'package:art_of_pilates/app/features/home/presentation/views/home_tab.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/packages_tab.dart';
import 'package:art_of_pilates/app/features/profile/presentation/views/profile_screen.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/views/schedule_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeStates> {
  final LaunchSocialUrlUseCase launchSocialUrlUseCase;
    String instagramUrl = 'https://www.instagram.com/artofpilates.sa?igsh=YmJmbDZzdzhmOGw3';
   final String whatsappUrl = 'https://wa.me/966556768112?text=Hello%2C%20I%20would%20like%20to%20inquire%20about%20a%20booking';
   String mapsUrl =
      'https://maps.app.goo.gl/FPtpu6VMmk5Z6Ur36?g_st=ipc';

  HomeViewModel(this.launchSocialUrlUseCase) : super(HomeStates());

  void onEvent(HomeEvents event) {
    if (event is ChangeTabEvent) {
      emit(HomeStates(currentIndex: event.index));
    }
  }

  Widget getTab(int index) {
    switch (index) {
      case 0:
        return HomeTab();
      case 1:
        return const ScheduleTab();
      case 2:
        return const PackagesTab();
      case 3:
        return const ProfileScreen();
      default:
        return HomeTab();
    }
  }

  Future<void> launchSocialUrl(String url) async {
    try {
      await launchSocialUrlUseCase(url);
    } catch (e) {
      debugPrint("Error launching URL: ${e.toString()}");
      rethrow;
    }
  }
}
