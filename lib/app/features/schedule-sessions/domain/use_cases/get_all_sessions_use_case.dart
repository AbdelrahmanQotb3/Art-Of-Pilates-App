import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/repo/sessions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllSessionsUseCase {
  final SessionsRepoContract sessionsRepoContract;
  GetAllSessionsUseCase(this.sessionsRepoContract);
  Future<BaseResponse<SessionsModel>> call() async => await sessionsRepoContract.getAllSessions();
}