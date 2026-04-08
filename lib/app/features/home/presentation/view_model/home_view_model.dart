import 'package:art_of_pilates/app/features/home/presentation/view_model/home_events.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_states.dart';
import 'package:art_of_pilates/app/features/home/presentation/views/home_tab.dart';
import 'package:art_of_pilates/app/features/packages/views/packages_tab.dart';
import 'package:art_of_pilates/app/features/profile/views/profile_tab.dart';
import 'package:art_of_pilates/app/features/schedule/views/schedule_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(HomeStates());

  void onEvent(HomeEvents event) {
    if (event is ChangeTabEvent) {
      emit(HomeStates(currentIndex: event.index));
    }
  }

  Widget getTab(int index) {
    switch (index) {
      case 0: return const HomeTab();
      case 1: return const ScheduleTab();
      case 2: return const PackagesTab();
      case 3: return const ProfileTab();
      default: return const HomeTab();
    }
  }
}