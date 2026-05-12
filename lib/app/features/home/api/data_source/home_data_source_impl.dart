import 'package:art_of_pilates/app/features/home/data/data_source/home_data_source_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable(as: HomeDataSourceContract)
class HomeDataSourceImpl implements HomeDataSourceContract {
  @override
  Future<void> launchSocialUrl(String url) async {
    if (url.isEmpty) return;
    final String sanitizedUrl = url.trim();
    final Uri uri = Uri.parse(sanitizedUrl);
    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );
      if (!launched) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      rethrow;
    }
  }
}
