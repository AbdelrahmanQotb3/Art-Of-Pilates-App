import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/packages/data/data_source/packages_data_source_contract.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plan_response.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plans_response.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/domain/repo/packages_repo_contract.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PackagesRepoContract)
class PackagesRepoImpl implements PackagesRepoContract {
  final PackagesDataSourceContract _dataSource;

  PackagesRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<PricingPlanModel>> getPackages() async {
    final response = await _dataSource.getPackages();
    switch (response) {
      case SuccessResponse<PricingPlansResponse>():
        final List<PricingPlanEntity> plans = (response.data.plans ?? [])
            .map(
              (e) => PricingPlanEntity(
                id: e.id,
                planName: e.planName,
                status: e.status,
                totalSessions: e.totalSessions,
                price: e.price,
                currency: e.currency,
                duration: e.duration,
                offerAsPackage: e.offerAsPackage,
                planDetails: e.planDetails,
                services: e.services?.map((s) {
                  return ServiceEntity(
                    id: s.id,
                    name: s.name,
                    imageUrl: s.imageUrl,
                  );
                }).toList(),
              ),
            )
            .toList();
        return SuccessResponse(data: PricingPlanModel(plans: plans));
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }

  @override
  Future<BaseResponse<PricingPlanEntity>> getOnePackage(int id) async {
    final response = await _dataSource.getOnePackage(id);
    switch (response) {
      case SuccessResponse<PricingPlanResponse>():
        final PricingPlanEntity plan = PricingPlanEntity(
          id: response.data.plan?.id,
          planName: response.data.plan?.planName,
          status: response.data.plan?.status,
          totalSessions: response.data.plan?.totalSessions,
          price: response.data.plan?.price,
          currency: response.data.plan?.currency,
          duration: response.data.plan?.duration,
          offerAsPackage: response.data.plan?.offerAsPackage,
          planDetails: response.data.plan?.planDetails,
          services: response.data.plan?.services?.map((s) {
            return ServiceEntity(id: s.id, name: s.name, price: s.price);
          }).toList(),
        );
        return SuccessResponse(data: plan);
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }
}
