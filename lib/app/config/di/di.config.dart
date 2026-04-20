// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../core/util/session_manager.dart' as _i32;
import '../../features/home/presentation/view_model/home_view_model.dart'
    as _i77;
import '../../features/packages/api/api_client/packages_api_client.dart'
    as _i899;
import '../../features/packages/api/data_source/packages_data_source_impl.dart'
    as _i293;
import '../../features/packages/data/data_source/packages_data_source_contract.dart'
    as _i526;
import '../../features/packages/data/repo/packages_repo_impl.dart' as _i543;
import '../../features/packages/domain/repo/packages_repo_contract.dart'
    as _i755;
import '../../features/packages/domain/use_cases/get_all_packages_use_case.dart'
    as _i369;
import '../../features/packages/domain/use_cases/get_one_package_use_case.dart'
    as _i689;
import '../../features/packages/domain/use_cases/navigate_to_package_details_screen.dart'
    as _i136;
import '../../features/packages/presentation/view_model/packages_view_model.dart'
    as _i187;
import '../../features/profile/api/api_client/profile_api_client.dart' as _i699;
import '../../features/profile/api/data_source/profile_data_source_impl.dart'
    as _i349;
import '../../features/profile/data/data_source/profile_data_source_contract.dart'
    as _i354;
import '../../features/profile/data/repo/profile_repo_impl.dart' as _i256;
import '../../features/profile/domain/repo/profile_repo_contract.dart' as _i541;
import '../../features/profile/domain/use_cases/edit_user_info_use_case.dart'
    as _i539;
import '../../features/profile/domain/use_cases/get_user_profile_use_case.dart'
    as _i903;
import '../../features/profile/domain/use_cases/navigate_to_edit_info_screen_use_case.dart'
    as _i660;
import '../../features/profile/presentation/view_model/profile_view_model.dart'
    as _i15;
import '../../features/schedule-sessions/api/api_client/sessions_api_client.dart'
    as _i281;
import '../../features/schedule-sessions/api/data_source/sessions_data_source_impl.dart'
    as _i26;
import '../../features/schedule-sessions/data/data_source/sessions_data_source_contract.dart'
    as _i239;
import '../../features/schedule-sessions/data/repo/sessions_repo_impl.dart'
    as _i817;
import '../../features/schedule-sessions/domain/repo/sessions_repo_contract.dart'
    as _i149;
import '../../features/schedule-sessions/domain/use_cases/get_all_sessions_use_case.dart'
    as _i796;
import '../../features/schedule-sessions/domain/use_cases/get_one_session_use_case.dart'
    as _i906;
import '../../features/schedule-sessions/presentation/view_model/sessions_view_model.dart'
    as _i45;
import '../../features/services/api/api_client/services_api_client.dart'
    as _i173;
import '../../features/services/api/data_source/services_data_source_impl.dart'
    as _i859;
import '../../features/services/data/data_souorce/services_data_source_contract.dart'
    as _i84;
import '../../features/services/data/repo/services_repo_impl.dart' as _i83;
import '../../features/services/domain/repo/services_repo_contract.dart'
    as _i726;
import '../../features/services/domain/use_cases/get_all_services_use_case.dart'
    as _i317;
import '../../features/services/domain/use_cases/get_one_service_use_case.dart'
    as _i978;
import '../../features/services/presentation/view_model/services_view_model.dart'
    as _i902;
import '../../features/signin/api/api_client/signin_api_client.dart' as _i219;
import '../../features/signin/api/data_source/signin_data_source_impl.dart'
    as _i257;
import '../../features/signin/data/data_source/signin_data_source_contract.dart'
    as _i556;
import '../../features/signin/data/repo/signin_repo_impl.dart' as _i905;
import '../../features/signin/domain/repo/signin_repo_contract.dart' as _i218;
import '../../features/signin/domain/use_cases/signin_use_case.dart' as _i557;
import '../../features/signin/presentation/view_model/signin_view_model.dart'
    as _i435;
import '../../features/signup/api/api_client/signup_api_client.dart' as _i208;
import '../../features/signup/api/data_source/signup_data_source_impl.dart'
    as _i300;
import '../../features/signup/data/data_source/signup_data_source_contract.dart'
    as _i89;
import '../../features/signup/data/repo/signup_repo_impl.dart' as _i868;
import '../../features/signup/domain/repo/signup_repo_contract.dart' as _i677;
import '../../features/signup/domain/use_case/signup_use_case.dart' as _i941;
import '../../features/signup/presentation/view_model/signup_view_model.dart'
    as _i85;
import '../dio_module/di_model.dart' as _i183;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i361.Dio>(() => dioModule.provideDio());
    gh.factory<_i528.PrettyDioLogger>(() => dioModule.dioLogger());
    gh.factory<_i77.HomeViewModel>(() => _i77.HomeViewModel());
    gh.factory<_i136.NavigateToPackageDetailsScreenUseCase>(
      () => _i136.NavigateToPackageDetailsScreenUseCase(),
    );
    gh.factory<_i660.NavigateToEditInfoScreenUseCase>(
      () => _i660.NavigateToEditInfoScreenUseCase(),
    );
    gh.lazySingleton<_i32.SessionManager>(() => _i32.SessionManager());
    gh.factory<_i899.PackagesApiClient>(
      () => _i899.PackagesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i699.ProfileApiClient>(
      () => _i699.ProfileApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i281.SessionsApiClient>(
      () => _i281.SessionsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i173.ServicesApiClient>(
      () => _i173.ServicesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i219.SigninApiClient>(
      () => _i219.SigninApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i208.SignupApiClient>(
      () => _i208.SignupApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i89.SignupDataSourceContract>(
      () => _i300.SignupDataSourceImpl(gh<_i208.SignupApiClient>()),
    );
    gh.factory<_i677.SignupRepoContract>(
      () => _i868.SignupRepoImpl(gh<_i89.SignupDataSourceContract>()),
    );
    gh.factory<_i354.ProfileDataSourceContract>(
      () => _i349.ProfileDataSourceImpl(gh<_i699.ProfileApiClient>()),
    );
    gh.factory<_i239.SessionsDataSourceContract>(
      () => _i26.SessionsDataSourceImpl(gh<_i281.SessionsApiClient>()),
    );
    gh.factory<_i556.SigninDataSourceContract>(
      () => _i257.SigninDataSourceImpl(gh<_i219.SigninApiClient>()),
    );
    gh.factory<_i941.SignupUseCase>(
      () => _i941.SignupUseCase(gh<_i677.SignupRepoContract>()),
    );
    gh.factory<_i85.SignupViewModel>(
      () => _i85.SignupViewModel(gh<_i941.SignupUseCase>()),
    );
    gh.factory<_i84.ServicesDataSourceContract>(
      () => _i859.ServicesDataSourceImpl(gh<_i173.ServicesApiClient>()),
    );
    gh.factory<_i149.SessionsRepoContract>(
      () => _i817.SessionsRepoImpl(gh<_i239.SessionsDataSourceContract>()),
    );
    gh.factory<_i526.PackagesDataSourceContract>(
      () => _i293.PackagesDataSourceImpl(gh<_i899.PackagesApiClient>()),
    );
    gh.factory<_i541.ProfileRepoContract>(
      () => _i256.ProfileRepoImpl(gh<_i354.ProfileDataSourceContract>()),
    );
    gh.factory<_i218.SigninRepoContract>(
      () => _i905.SigninRepoImpl(gh<_i556.SigninDataSourceContract>()),
    );
    gh.factory<_i796.GetAllSessionsUseCase>(
      () => _i796.GetAllSessionsUseCase(gh<_i149.SessionsRepoContract>()),
    );
    gh.factory<_i906.GetOneSessionUseCase>(
      () => _i906.GetOneSessionUseCase(gh<_i149.SessionsRepoContract>()),
    );
    gh.factory<_i45.SessionsViewModel>(
      () => _i45.SessionsViewModel(
        gh<_i796.GetAllSessionsUseCase>(),
        gh<_i906.GetOneSessionUseCase>(),
      ),
    );
    gh.factory<_i726.ServicesRepoContract>(
      () => _i83.ServicesRepoImpl(gh<_i84.ServicesDataSourceContract>()),
    );
    gh.factory<_i755.PackagesRepoContract>(
      () => _i543.PackagesRepoImpl(gh<_i526.PackagesDataSourceContract>()),
    );
    gh.factory<_i539.EditUserInfoUseCase>(
      () => _i539.EditUserInfoUseCase(gh<_i541.ProfileRepoContract>()),
    );
    gh.factory<_i903.GetUserProfileUseCase>(
      () => _i903.GetUserProfileUseCase(gh<_i541.ProfileRepoContract>()),
    );
    gh.factory<_i557.SigninUseCase>(
      () => _i557.SigninUseCase(gh<_i218.SigninRepoContract>()),
    );
    gh.factory<_i369.GetAllPackagesUseCase>(
      () => _i369.GetAllPackagesUseCase(gh<_i755.PackagesRepoContract>()),
    );
    gh.factory<_i689.GetOnePackageUseCase>(
      () => _i689.GetOnePackageUseCase(gh<_i755.PackagesRepoContract>()),
    );
    gh.factory<_i435.SigninViewModel>(
      () => _i435.SigninViewModel(gh<_i557.SigninUseCase>()),
    );
    gh.factory<_i15.ProfileViewModel>(
      () => _i15.ProfileViewModel(
        gh<_i903.GetUserProfileUseCase>(),
        gh<_i539.EditUserInfoUseCase>(),
      ),
    );
    gh.factory<_i187.PackagesViewModel>(
      () => _i187.PackagesViewModel(
        gh<_i369.GetAllPackagesUseCase>(),
        gh<_i689.GetOnePackageUseCase>(),
      ),
    );
    gh.factory<_i317.GetAllServicesUseCase>(
      () => _i317.GetAllServicesUseCase(gh<_i726.ServicesRepoContract>()),
    );
    gh.factory<_i978.GetOneServiceUseCase>(
      () => _i978.GetOneServiceUseCase(gh<_i726.ServicesRepoContract>()),
    );
    gh.factory<_i902.ServicesViewModel>(
      () => _i902.ServicesViewModel(
        gh<_i317.GetAllServicesUseCase>(),
        gh<_i978.GetOneServiceUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i183.DioModule {}
