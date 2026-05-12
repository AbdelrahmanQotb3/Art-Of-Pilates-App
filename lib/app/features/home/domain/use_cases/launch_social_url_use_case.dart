import 'package:art_of_pilates/app/features/home/domain/repo/home_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LaunchSocialUrlUseCase {
  final HomeRepoContract _homeRepo;

  LaunchSocialUrlUseCase(this._homeRepo);

  Future<void> call(String url) async {
    try {
      await _homeRepo.launchSocialUrl(url);
    } catch (e) {
      rethrow;
    }
  }
}