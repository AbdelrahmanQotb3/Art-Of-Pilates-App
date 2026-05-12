import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/core/util/exceptions/payment/payment_exception.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/create_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/verify_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/use_cases/create_charge_use_case.dart';
import 'package:art_of_pilates/app/features/payment/domain/use_cases/create_plan_charge_use_case.dart';
import 'package:art_of_pilates/app/features/payment/domain/use_cases/verify_charge_use_case.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_events.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentViewModel extends Cubit<PaymentStates> {
  final CreateChargeUseCase _createChargeUseCase;
  final CreatePlanChargeUseCase _createPlanChargeUseCase;
  final VerifyChargeUseCase _verifyChargeUseCase;

  PaymentViewModel(
    this._createChargeUseCase,
    this._createPlanChargeUseCase,
    this._verifyChargeUseCase,
  ) : super(PaymentStates());

  void onEvent(PaymentEvents event) {
    if (event is CreateChargeEvent) {
      _createCharge(event.sessionId);
    } else if (event is CreatePlanChargeEvent) {
      _createPlanCharge(event.planId);
    } else if (event is VerifyChargeEvent) {
      _verifyCharge(event.chargeId);
    }
  }

  AppException _mapToAppException(Exception error) {
    if (error is AppException) return error;
    return PaymentException(error: error.toString());
  }

  Future<BaseResponse<CreateChargeModel>> _createCharge(
    String sessionId,
  ) async {
    emit(
      state.copyWith(
        createChargeState: BaseState<CreateChargeModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );

    final response = await _createChargeUseCase(sessionId);
    switch (response) {
      case SuccessResponse<CreateChargeModel>():
        emit(
          state.copyWith(
            createChargeState: BaseState<CreateChargeModel>(
              data: response.data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: response.data);
      case ErrorResponse<CreateChargeModel>():
        final appException = _mapToAppException(response.error);
        emit(
          state.copyWith(
            createChargeState: BaseState<CreateChargeModel>(
              errorMessage: appException.createErrorMessage(),
              isLoading: false,
            ),
            appExceptionParam: appException,
          ),
        );
        return ErrorResponse(error: response.error);
    }
  }

  Future<void> _verifyCharge(String chargeId) async {
    emit(
      state.copyWith(
        verifyChargeState: BaseState<VerifyChargeModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );

    final response = await _verifyChargeUseCase(chargeId);
    switch (response) {
      case SuccessResponse<VerifyChargeModel>():
        emit(
          state.copyWith(
            verifyChargeState: BaseState<VerifyChargeModel>(
              data: response.data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
      case ErrorResponse<VerifyChargeModel>():
        final appException = _mapToAppException(response.error);
        emit(
          state.copyWith(
            verifyChargeState: BaseState<VerifyChargeModel>(
              errorMessage: appException.createErrorMessage(),
              isLoading: false,
            ),
            appExceptionParam: appException,
          ),
        );
    }
  }

  Future<BaseResponse<CreateChargeModel>> _createPlanCharge(int planId) async {
    emit(
      state.copyWith(
        createChargeState: BaseState<CreateChargeModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );
    final response = await _createPlanChargeUseCase(planId);
    switch (response) {
      case SuccessResponse<CreateChargeModel>():
        emit(
          state.copyWith(
            createChargeState: BaseState<CreateChargeModel>(
              data: response.data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: response.data);
      case ErrorResponse<CreateChargeModel>():
        final appException = _mapToAppException(response.error);
        emit(
          state.copyWith(
            createChargeState: BaseState<CreateChargeModel>(
              errorMessage: appException.createErrorMessage(),
              isLoading: false,
            ),
            appExceptionParam: appException,
          ),
        );
        return ErrorResponse(error: response.error);
    }
  }
}
