import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/services/data/model/one_service_response.dart';
import 'package:art_of_pilates/app/features/services/data/model/services_response.dart';

abstract class ServicesDataSourceContract {
  Future<BaseResponse<ServicesResponse>> getAllServices();
  Future<BaseResponse<OneServiceResponse>> getOneService(String id);
}
