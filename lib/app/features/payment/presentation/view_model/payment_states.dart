import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/create_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/verify_charge_model.dart';

class PaymentStates {
  BaseState<CreateChargeModel>? createChargeState;
  BaseState<VerifyChargeModel>? verifyChargeState;
  AppException? appException;

  PaymentStates({
    this.createChargeState,
    this.verifyChargeState,
    this.appException,
  });

  PaymentStates copyWith({
    BaseState<CreateChargeModel>? createChargeState,
    BaseState<VerifyChargeModel>? verifyChargeState,
    Object? appExceptionParam = _sentinel,
  }) {
    return PaymentStates(
      createChargeState: createChargeState ?? this.createChargeState,
      verifyChargeState: verifyChargeState ?? this.verifyChargeState,
      appException: appExceptionParam == _sentinel
          ? appException
          : appExceptionParam as AppException?,
    );
  }

  static const _sentinel = Object();
}
