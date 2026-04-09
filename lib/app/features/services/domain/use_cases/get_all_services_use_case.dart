import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';
import 'package:art_of_pilates/app/features/services/domain/repo/services_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllServicesUseCase {
  final ServicesRepoContract _servicesRepoContract;

  GetAllServicesUseCase(this._servicesRepoContract);

  Future<BaseResponse<ServicesModel>> call() => _servicesRepoContract.getAllServices();
}