import 'package:dio/dio.dart';

import '../../constants/core_network.dart';
import 'base_dio.dart';
import 'not_logged_interceptor.dart';

class NotLoggedDio extends BaseDio {
  NotLoggedDio({
    required NotLoggedInterceptor notLoggedInterceptor,
    BaseOptions? options,
  }) : super(
          options: options ??
              BaseOptions(
                baseUrl: 'http://localhost:8080', // CoreNetwork.baseUrl,
                connectTimeout: const Duration(seconds: CoreNetwork.timeoutLimit),
                receiveTimeout: const Duration(seconds: CoreNetwork.timeoutLimit),
              ),
          isMock: const String.fromEnvironment('SUFIX') == 'dev',
          customInterceptors: [
            if (const String.fromEnvironment('SUFIX') == 'dev') notLoggedInterceptor,
            // if (environment is DevEnvironment) mockInterceptor,
          ],
        );
}
