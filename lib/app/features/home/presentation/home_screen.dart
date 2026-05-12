import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_events.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_states.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<HomeViewModel>();
    if (initialIndex != 0) {
      viewModel.onEvent(ChangeTabEvent(initialIndex));
    }
    return BlocProvider.value(
      value: viewModel,
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: viewModel.getTab(state.currentIndex),
            bottomNavigationBar: _buildBottomNavigationBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, HomeStates state) {
    final locale = appLocale(context);
    final viewModel = context.read<HomeViewModel>();
    return BottomNavigationBar(
      onTap: (value) => viewModel.onEvent(ChangeTabEvent(value)),
      currentIndex: state.currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: locale.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_month_outlined),
          label: locale.schedule,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.local_offer_outlined),
          label: locale.packages,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people_outlined),
          label: locale.myAccounts,
        ),
      ],
    );
  }
}
