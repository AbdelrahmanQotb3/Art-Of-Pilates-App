import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/repo/sessions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOneSessionUseCase {
  final SessionsRepoContract _sessionsRepoContract;

  GetOneSessionUseCase(this._sessionsRepoContract);

  Future<BaseResponse<SessionEntity>> call(String id) async => await _sessionsRepoContract.getOneSession(id);
}