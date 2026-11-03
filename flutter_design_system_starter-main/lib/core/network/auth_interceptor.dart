import 'package:dio/dio.dart';

typedef TokenProvider = String? Function();
typedef UnauthorizedCallback = void Function();

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    this.tokenProvider,
    this.onUnauthorized,
  });

  final TokenProvider? tokenProvider;
  final UnauthorizedCallback? onUnauthorized;

  String? _token;

  void setToken(String? token) {
    _token = token;
  }

  String? get token => _token ?? tokenProvider?.call();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final currentToken = token;
    if (currentToken != null && currentToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $currentToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      onUnauthorized?.call();
    }
    super.onError(err, handler);
  }
}
