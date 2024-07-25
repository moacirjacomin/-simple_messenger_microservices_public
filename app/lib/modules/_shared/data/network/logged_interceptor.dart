import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/core_network.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/usecases/authentication/get_current_user_usecase.dart';
import '../../domain/usecases/authentication/logout_usecase.dart';
import '../../domain/usecases/authentication/update_auth_user_usecase.dart';
import '../../shared_navigator.dart';

class LoggedInterceptor implements InterceptorsWrapper {
  final UpdateCurrentUserUsecase? updateCurrentUserUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final LogoutUsecase logoutUsecase;
  final SharedNavigator sharedNavigator;
  final VoidCallback? onUnauthorized;

  LoggedInterceptor({
    this.updateCurrentUserUsecase,
    required this.getCurrentUserUsecase,
    required this.logoutUsecase,
    required this.sharedNavigator,
    this.onUnauthorized,
  });

  CurrentUser? _currentUser;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {


    _currentUser = await getCurrentUserUsecase!();

    print('..._currentUser=${_currentUser}');

    if (_currentUser != null) {
      var at = _currentUser?.token ?? ' ';
      options.headers.addAll({'Authorization': 'Bearer '+  at });
    }

    return handler.next(options);
  }

  @override
  Future onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final cookie = response.headers['set-cookie']?.first;

    if (cookie != null && cookie != _currentUser?.token) {
      _currentUser!.token = cookie;
        updateCurrentUserUsecase!(_currentUser!);
    }

    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {

    var codeUnauthorizedCode = [CoreNetwork.codeUnauthorized, CoreNetwork.codeForbidden]; // 401, 403

    if (err.type.runtimeType == DioExceptionType && err.response != null && codeUnauthorizedCode.contains(err.response!.statusCode) ) {
      // onUnauthorized?.call();
      logoutUsecase();
      sharedNavigator.openLogin();
    }

    return handler.next(err);
  }
}
