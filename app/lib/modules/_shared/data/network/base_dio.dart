import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constants/core_network.dart';

abstract class BaseDio extends DioForNative {
  BaseDio({
    List<Interceptor>? customInterceptors,
    BaseOptions? options,
    bool isMock = false,
  }) : super(
          BaseOptions(
            baseUrl: options?.baseUrl ?? CoreNetwork.baseUrl,
            connectTimeout: options?.connectTimeout ?? const Duration(seconds: CoreNetwork.timeoutLimit),
            receiveTimeout: options?.receiveTimeout ?? const Duration(seconds: CoreNetwork.timeoutLimit),
          ),
        ) {
    // if (kDebugMode && !isMock) {
      interceptors.addAll([
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          maxWidth: 120,
          logPrint: (obj) => debugPrint(obj as String?),
        ),
        // LogInterceptor(
        //   requestBody: true,
        //   responseBody: true,
        // ),
      ]);
    // }

    if (customInterceptors?.isNotEmpty == true) {
      interceptors.addAll(customInterceptors!);
    }

    print('... RODEI AQUI ${options?.baseUrl} ${CoreNetwork.baseUrl} final=${options?.baseUrl ?? CoreNetwork.baseUrl}');
    this.options = BaseOptions(
      baseUrl: options?.baseUrl ?? CoreNetwork.baseUrl,
      connectTimeout: options?.connectTimeout ?? const Duration(seconds: CoreNetwork.timeoutLimit),
    );
  }
}
