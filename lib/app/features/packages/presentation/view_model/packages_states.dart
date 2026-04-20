import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';

class PackagesStates {
  BaseState<PricingPlanModel>? packagesState;
  BaseState<PricingPlanEntity>? onePackageState;

  PackagesStates({this.packagesState , this.onePackageState});

  PackagesStates copyWith({BaseState<PricingPlanModel>? packagesState , BaseState<PricingPlanEntity>? onePackageState}) => PackagesStates(packagesState: packagesState ?? this.packagesState , onePackageState: onePackageState ?? this.onePackageState);
}