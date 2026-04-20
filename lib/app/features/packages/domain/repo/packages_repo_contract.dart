import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';

abstract class PackagesRepoContract {
  Future<BaseResponse<PricingPlanModel>> getPackages();
  Future<BaseResponse<PricingPlanEntity>> getOnePackage(int id);
}