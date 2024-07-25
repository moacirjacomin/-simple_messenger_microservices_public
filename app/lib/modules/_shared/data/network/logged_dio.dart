import 'package:dio/dio.dart';

import '../../constants/core_network.dart';
import 'base_dio.dart';
import 'logged_interceptor.dart';

class LoggedDio extends BaseDio {
  LoggedDio({
    required LoggedInterceptor loggedInterceptor,
    BaseOptions? options,
  }) : super(
          options: options ??
              BaseOptions(
                baseUrl:  'http://localhost:8080', // CoreNetwork.baseUrl,
                connectTimeout:  const Duration(seconds: CoreNetwork.timeoutLimit),
                receiveTimeout:  const Duration(seconds: CoreNetwork.timeoutLimit),
              ),
          isMock: const String.fromEnvironment('SUFIX') == 'dev',
          customInterceptors: [
            if ( String.fromEnvironment('SUFIX') != 'dev') loggedInterceptor,
            // if (environment is DevEnvironment) mockInterceptor,
          ],
        );
}
