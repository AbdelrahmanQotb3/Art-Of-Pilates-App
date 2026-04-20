import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/packages/api/api_client/packages_api_client.dart';
import 'package:art_of_pilates/app/features/packages/data/data_source/packages_data_source_contract.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plan_response.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plans_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PackagesDataSourceContract)
class PackagesDataSourceImpl implements PackagesDataSourceContract {
  final PackagesApiClient _apiClient;

  PackagesDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<PricingPlansResponse>> getPackages() async {
    try {
      final response = await _apiClient.getAllPackages();
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<PricingPlanResponse>> getOnePackage(int id) async {
    try {
      final response = await _apiClient.getPackageById(id);
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }
}
