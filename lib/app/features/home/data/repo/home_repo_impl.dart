import 'package:art_of_pilates/app/features/home/data/data_source/home_data_source_contract.dart';
import 'package:art_of_pilates/app/features/home/domain/repo/home_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImpl implements HomeRepoContract {
  final HomeDataSourceContract _dataSource;

  HomeRepoImpl(this._dataSource);

  @override
  Future<void> launchSocialUrl(String url) async {
    try {
      await _dataSource.launchSocialUrl(url);
    } catch (e) {
      rethrow;
    }
  }
}