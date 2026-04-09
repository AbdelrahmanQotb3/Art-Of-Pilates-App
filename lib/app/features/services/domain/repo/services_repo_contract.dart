import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';

abstract class ServicesRepoContract {
  Future<BaseResponse<ServicesModel>> getAllServices();
  Future<BaseResponse<ServiceEntity>> getOneService(String id); 
}