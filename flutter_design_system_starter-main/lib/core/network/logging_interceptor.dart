import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌─────────────────────────────────────────────────────────');
      debugPrint('│ [HTTP REQUEST] ${options.method.toUpperCase()} ${options.uri}');
      if (options.headers.isNotEmpty) {
        debugPrint('│ Headers: ${options.headers}');
      }
      if (options.queryParameters.isNotEmpty) {
        debugPrint('│ Query: ${options.queryParameters}');
      }
      if (options.data != null) {
        debugPrint('│ Body: ${options.data}');
      }
      debugPrint('└─────────────────────────────────────────────────────────');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌─────────────────────────────────────────────────────────');
      debugPrint(
        '│ [HTTP RESPONSE] [${response.statusCode}] ${response.requestOptions.method} ${response.requestOptions.uri}',
      );
      debugPrint('│ Data: ${response.data}');
      debugPrint('└─────────────────────────────────────────────────────────');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌─────────────────────────────────────────────────────────');
      debugPrint(
        '│ [HTTP ERROR] [${err.response?.statusCode ?? 'NO_STATUS'}] ${err.requestOptions.method} ${err.requestOptions.uri}',
      );
      debugPrint('│ Message: ${err.message}');
      if (err.response?.data != null) {
        debugPrint('│ Response Error Data: ${err.response?.data}');
      }
      debugPrint('└─────────────────────────────────────────────────────────');
    }
    super.onError(err, handler);
  }
}
