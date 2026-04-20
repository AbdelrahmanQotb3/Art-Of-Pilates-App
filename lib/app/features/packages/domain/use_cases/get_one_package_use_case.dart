import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/domain/repo/packages_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOnePackageUseCase {
  final PackagesRepoContract _packagesRepoContract;

  GetOnePackageUseCase(this._packagesRepoContract);
  Future<BaseResponse<PricingPlanEntity>> call(int id) {
    return _packagesRepoContract.getOnePackage(id);
  }
}