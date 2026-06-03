import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/announcments/api/api_client/announcment_api_client.dart';
import 'package:art_of_pilates/app/features/announcments/data/data_source/announcments_data_source_contract.dart';
import 'package:art_of_pilates/app/features/announcments/data/model/announcments_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AnnouncmentsDataSourceContract)
class AnnouncmentsDataSourceImpl implements AnnouncmentsDataSourceContract {
  final AnnouncmentApiClient _apiClient;

  AnnouncmentsDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<AnnouncmentsResponse>> getAllAnnouncements() async {
    try{
      final response = await _apiClient.getAllAnnouncements();
      return SuccessResponse(data: response);

    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }
}