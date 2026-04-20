import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/domain/use_cases/get_all_packages_use_case.dart';
import 'package:art_of_pilates/app/features/packages/domain/use_cases/get_one_package_use_case.dart';
import 'package:art_of_pilates/app/features/packages/presentation/view_model/packages_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PackagesViewModel extends Cubit<PackagesStates> {
  final GetAllPackagesUseCase _getAllPackagesUseCase;
  final GetOnePackageUseCase _getOnePackageUseCase;
  PackagesViewModel(this._getAllPackagesUseCase , this._getOnePackageUseCase) : super(PackagesStates());

  Future<BaseResponse<PricingPlanModel>> getAllPackages() async {
    emit(state.copyWith(packagesState: BaseState<PricingPlanModel>(isLoading: true)));
    final response = await _getAllPackagesUseCase.call();
    switch (response) {
      case SuccessResponse<PricingPlanModel>():
        emit(state.copyWith(packagesState: BaseState<PricingPlanModel>(data: response.data, isLoading: false)));
        return response;
      case ErrorResponse<PricingPlanModel>():
        emit(state.copyWith(packagesState: BaseState<PricingPlanModel>(errorMessage: response.error.toString(), isLoading: false)));
        return response;
    }
  }

  Future<BaseResponse<PricingPlanEntity>> getOnePackage(int id) async{
    emit(state.copyWith(onePackageState: BaseState<PricingPlanEntity>(isLoading: true)));
    final response = await _getOnePackageUseCase.call(id);
    switch (response) {
      case SuccessResponse<PricingPlanEntity>():
        emit(state.copyWith(onePackageState: BaseState<PricingPlanEntity>(data: response.data, isLoading: false)));
        return response;
      case ErrorResponse<PricingPlanEntity>():
        emit(state.copyWith(onePackageState: BaseState<PricingPlanEntity>(errorMessage: response.error.toString(), isLoading: false)));
        return response;
    }
  }
}