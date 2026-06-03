import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/announcments/data/model/announcments_response.dart';

abstract class AnnouncmentsDataSourceContract {
  Future<BaseResponse<AnnouncmentsResponse>> getAllAnnouncements();
}