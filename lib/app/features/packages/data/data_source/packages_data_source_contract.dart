import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plan_response.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plans_response.dart';

abstract class PackagesDataSourceContract {

  Future<BaseResponse<PricingPlansResponse>> getPackages();

  Future<BaseResponse<PricingPlanResponse>> getOnePackage(int id);
}