import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/announcments/data/data_source/announcments_data_source_contract.dart';
import 'package:art_of_pilates/app/features/announcments/data/model/announcments_response.dart';
import 'package:art_of_pilates/app/features/announcments/domain/model/announcments_model.dart';
import 'package:art_of_pilates/app/features/announcments/domain/repo/announcments_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AnnouncmentsRepoContract)
class AnnouncmentsRepoImpl implements AnnouncmentsRepoContract {
  final AnnouncmentsDataSourceContract _dataSource;

  AnnouncmentsRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<AnnouncmentsModel>> getAllAnnouncements() async {
    final response = await _dataSource.getAllAnnouncements();
    switch (response) {
      case SuccessResponse<AnnouncmentsResponse>():
        return SuccessResponse(
          data: AnnouncmentsModel(
            message: response.data.message,
            announcements: response.data.announcements
                ?.map(
                  (announcement) => AnnouncmentEntity(
                    id: announcement.id,
                    title: announcement.title,
                    content: announcement.content,
                    createdAt: DateTime.tryParse(announcement.createdAt ?? ''),
                    updatedAt: DateTime.tryParse(announcement.updatedAt ?? ''),
                    type: announcement.type,
                  ),
                )
                .toList(),
          ),
        );
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }
}
