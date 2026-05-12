import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/core/util/session_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @factoryMethod
  Dio provideDio() {
    final SessionManager sessionManager = SessionManager();
    Dio dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 180),
      receiveDataWhenStatusError: true,
      baseUrl: AppEndPoints.baseUrl,
      validateStatus: (status) {
        return status != null && status >= 200 && status < 300;
      },
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await sessionManager.getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
    return dio;
  }

  @factoryMethod
  PrettyDioLogger dioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 140,
    );
  }
}
