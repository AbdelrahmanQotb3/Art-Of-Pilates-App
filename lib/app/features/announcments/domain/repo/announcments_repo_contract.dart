import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/announcments/domain/model/announcments_model.dart';

abstract class AnnouncmentsRepoContract {
  Future<BaseResponse<AnnouncmentsModel>> getAllAnnouncements();
}
