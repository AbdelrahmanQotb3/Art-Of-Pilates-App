import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';
import 'package:art_of_pilates/app/features/services/domain/use_cases/get_all_services_use_case.dart';
import 'package:art_of_pilates/app/features/services/domain/use_cases/get_one_service_use_case.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_events.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ServicesViewModel extends Cubit<ServicesStates> {
  final GetAllServicesUseCase _getAllServicesUseCase;
  final GetOneServiceUseCase _getOneServiceUseCase;
  ServicesViewModel(
    this._getAllServicesUseCase,
    this._getOneServiceUseCase,
  ) : super(ServicesStates());

  void doIntent(ServicesEvents event) {
    if (event is ServicesEvent) {
      getAllServices();
    } else if (event is OneServiceEvent) {
      getOneService(event.serviceId);
    }
  }

  Future<BaseResponse<ServicesModel>> getAllServices() async {
    emit(
      state.copyWith(servicesState: BaseState<ServicesModel>(isLoading: true)),
    );
    final response = await _getAllServicesUseCase.call();
    switch (response) {
      case SuccessResponse<ServicesModel>():
        emit(
          state.copyWith(
            servicesState: BaseState<ServicesModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return response;
      case ErrorResponse<ServicesModel>():
        emit(
          state.copyWith(
            servicesState: BaseState<ServicesModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return response;
    }
  }

  Future<BaseResponse<ServiceEntity>> getOneService(String id) async {
    emit(
      state.copyWith(
        oneServiceState: BaseState<ServiceEntity>(isLoading: true),
      ),
    );
    final response = await _getOneServiceUseCase.call(id);
    switch (response) {
      case SuccessResponse<ServiceEntity>():
        emit(
          state.copyWith(
            oneServiceState: BaseState<ServiceEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return response;
      case ErrorResponse<ServiceEntity>():
        emit(
          state.copyWith(
            oneServiceState: BaseState<ServiceEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return response;
    }
  }
}
