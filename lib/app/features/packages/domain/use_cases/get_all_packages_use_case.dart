import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/domain/repo/packages_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllPackagesUseCase {
  final PackagesRepoContract _packagesRepoContract;
  GetAllPackagesUseCase(this._packagesRepoContract);
  Future<BaseResponse<PricingPlanModel>> call() async => await _packagesRepoContract.getPackages();
}