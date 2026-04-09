import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';

class ServicesStates {
    BaseState<ServicesModel>? servicesState;
    BaseState<ServiceEntity>? oneServiceState;

  ServicesStates({this.servicesState , this.oneServiceState});

  ServicesStates copyWith({BaseState<ServicesModel>? servicesState, BaseState<ServiceEntity>? oneServiceState}) {
    return ServicesStates(servicesState: servicesState ?? this.servicesState, oneServiceState: oneServiceState ?? this.oneServiceState);
  }

}