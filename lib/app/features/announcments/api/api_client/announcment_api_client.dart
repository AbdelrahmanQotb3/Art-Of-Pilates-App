import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/announcments/data/model/announcments_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'announcment_api_client.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
@injectable
abstract class AnnouncmentApiClient {
  @factoryMethod
  factory AnnouncmentApiClient(Dio dio) = _AnnouncmentApiClient;
  @GET(AppEndPoints.getAnnouncements)
  Future<AnnouncmentsResponse> getAllAnnouncements();
}