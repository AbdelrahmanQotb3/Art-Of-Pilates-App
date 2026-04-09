import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/services/api/api_client/services_api_client.dart';
import 'package:art_of_pilates/app/features/services/data/data_souorce/services_data_source_contract.dart';
import 'package:art_of_pilates/app/features/services/data/model/one_service_response.dart';
import 'package:art_of_pilates/app/features/services/data/model/services_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ServicesDataSourceContract)
class ServicesDataSourceImpl implements ServicesDataSourceContract {
  final ServicesApiClient _servicesApiClient;

  ServicesDataSourceImpl(this._servicesApiClient);

  @override
  Future<BaseResponse<ServicesResponse>> getAllServices() async {
    try {
      final response = await _servicesApiClient.getAllServices();
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<OneServiceResponse>> getOneService(String id) async {
    try {
      final response = await _servicesApiClient.getOneService(id);
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }
}
