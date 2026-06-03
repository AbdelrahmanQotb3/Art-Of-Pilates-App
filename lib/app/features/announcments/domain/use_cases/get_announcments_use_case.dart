import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/announcments/domain/model/announcments_model.dart';
import 'package:art_of_pilates/app/features/announcments/domain/repo/announcments_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAnnouncmentsUseCase {
  final AnnouncmentsRepoContract _announcmentsRepoContract;

  GetAnnouncmentsUseCase(this._announcmentsRepoContract);

  Future<BaseResponse<AnnouncmentsModel>> call() async => await _announcmentsRepoContract.getAllAnnouncements();
}