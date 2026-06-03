import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/join_waiting_list_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class JoinWaitingListUseCase {
  final BookingsRepoContract _bookingsRepoContract;

  JoinWaitingListUseCase(this._bookingsRepoContract);

  Future<BaseResponse<JoinWaitingListModel>> call(String sessionId) async {
    return await _bookingsRepoContract.joinWaitingList(sessionId);
  }
}