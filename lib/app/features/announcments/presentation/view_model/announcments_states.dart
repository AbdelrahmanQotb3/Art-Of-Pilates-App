import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/announcments/domain/model/announcments_model.dart';

class AnnouncmentsStates {
  BaseState<AnnouncmentsModel>? announcmentsState;

  AnnouncmentsStates({this.announcmentsState});

  AnnouncmentsStates copyWith({BaseState<AnnouncmentsModel>? announcmentsState}) {
    return AnnouncmentsStates(announcmentsState: announcmentsState ?? this.announcmentsState);
  }
}