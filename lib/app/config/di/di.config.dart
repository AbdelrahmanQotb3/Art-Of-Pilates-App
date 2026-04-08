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

import '../../features/home/presentation/view_model/home_view_model.dart'
    as _i77;
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
    gh.factory<_i556.SigninDataSourceContract>(
      () => _i257.SigninDataSourceImpl(gh<_i219.SigninApiClient>()),
    );
    gh.factory<_i941.SignupUseCase>(
      () => _i941.SignupUseCase(gh<_i677.SignupRepoContract>()),
    );
    gh.factory<_i85.SignupViewModel>(
      () => _i85.SignupViewModel(gh<_i941.SignupUseCase>()),
    );
    gh.factory<_i218.SigninRepoContract>(
      () => _i905.SigninRepoImpl(gh<_i556.SigninDataSourceContract>()),
    );
    gh.factory<_i557.SigninUseCase>(
      () => _i557.SigninUseCase(gh<_i218.SigninRepoContract>()),
    );
    gh.factory<_i435.SigninViewModel>(
      () => _i435.SigninViewModel(gh<_i557.SigninUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i183.DioModule {}
