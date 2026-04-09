import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/services/data/data_souorce/services_data_source_contract.dart';
import 'package:art_of_pilates/app/features/services/data/model/one_service_response.dart';
import 'package:art_of_pilates/app/features/services/data/model/services_response.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';
import 'package:art_of_pilates/app/features/services/domain/repo/services_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ServicesRepoContract)
class ServicesRepoImpl implements ServicesRepoContract {
  final ServicesDataSourceContract _servicesDataSource;

  ServicesRepoImpl(this._servicesDataSource);

  @override
  Future<BaseResponse<ServicesModel>> getAllServices() async {
    final response = await _servicesDataSource.getAllServices();
    switch (response) {
      case SuccessResponse<ServicesResponse>():
        final List<ServiceEntity> services = (response.data.services ?? []).map(
          (e) {
            return ServiceEntity(
              id: e.id,
              name: e.name,
              imageUrl: e.imageUrl,
              price: e.price,
              currency: e.currency,
              isVisible: e.isVisible,
              index: e.index,
              createdAt: e.createdAt,
              updatedAt: e.updatedAt,
              location: e.location,
              sessions: e.sessions?.map((s) {
                return SessionEntity(
                  id: s.id,
                  startTime: s.startTime,
                  endTime: s.endTime,
                  serviceId: s.serviceId,
                  staffMemberId: s.staffMemberId,
                  serviceName: s.service?.name,
                  staffName: s.staffMember?.name,
                );
              }).toList(),
            );
          },
        ).toList();
        return SuccessResponse<ServicesModel>(
          data: ServicesModel(services: services),
        );
      case ErrorResponse<ServicesResponse>():
        return ErrorResponse<ServicesModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ServiceEntity>> getOneService(String id) async {
    final response = await _servicesDataSource.getOneService(id);
    switch (response) {
      case SuccessResponse<OneServiceResponse>():
        ServiceEntity serviceModel = ServiceEntity(
          id: response.data.service?.id,
          name: response.data.service?.name,
          imageUrl: response.data.service?.imageUrl,
          price: response.data.service?.price,
          currency: response.data.service?.currency,
          isVisible: response.data.service?.isVisible,
          index: response.data.service?.index,
          createdAt: response.data.service?.createdAt,
          updatedAt: response.data.service?.updatedAt,
          location: response.data.service?.location,
          sessions: response.data.service?.sessions?.map((s) {
            return SessionEntity(
              id: s.id,
              startTime: s.startTime,
              endTime: s.endTime,
              serviceId: s.serviceId,
              staffMemberId: s.staffMemberId,
              serviceName: s.service?.name,
              staffName: s.staffMember?.name,
            );
          }).toList(),
        );
        return SuccessResponse(data: serviceModel);
      case ErrorResponse<OneServiceResponse>():
        return ErrorResponse(error: response.error);
    }
  }
}
