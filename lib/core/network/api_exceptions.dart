import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  final String message;
  final int? statusCode;
  final dynamic data;

  factory ApiException.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;
        String? serverMessage;

        if (responseData is Map && responseData['message'] != null) {
          serverMessage = responseData['message'].toString();
        } else if (responseData is String && responseData.isNotEmpty) {
          serverMessage = responseData;
        }

        switch (statusCode) {
          case 400:
            return BadRequestException(
              message: serverMessage ?? 'Invalid request format or parameters.',
              statusCode: statusCode,
              data: responseData,
            );
          case 401:
            return UnauthorizedException(
              message: serverMessage ?? 'Session expired or unauthenticated.',
              statusCode: statusCode,
              data: responseData,
            );
          case 403:
            return ForbiddenException(
              message: serverMessage ?? 'Access forbidden. You do not have permission.',
              statusCode: statusCode,
              data: responseData,
            );
          case 404:
            return NotFoundException(
              message: serverMessage ?? 'Requested resource was not found.',
              statusCode: statusCode,
              data: responseData,
            );
          case 500:
          case 502:
          case 503:
            return ServerException(
              message: serverMessage ?? 'Internal server error. Please try again later.',
              statusCode: statusCode,
              data: responseData,
            );
          default:
            return ApiException(
              message: serverMessage ?? 'Received invalid status code: $statusCode',
              statusCode: statusCode,
              data: responseData,
            );
        }

      case DioExceptionType.connectionError:
        return const NetworkConnectionException();

      case DioExceptionType.cancel:
        return const ApiException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const ApiException(message: 'Security certificate verification failed.');

      case DioExceptionType.unknown:
      default:
        return ApiException(
          message: error.message ?? 'An unexpected network error occurred.',
        );
    }
  }

  @override
  String toString() => message;
}

class TimeoutException extends ApiException {
  const TimeoutException({
    super.message = 'Connection timed out. Please check your internet connection.',
  });
}

class NetworkConnectionException extends ApiException {
  const NetworkConnectionException({
    super.message = 'No internet connection. Please verify your network.',
  });
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'Unauthorized. Please sign in again.',
    super.statusCode = 401,
    super.data,
  });
}

class ForbiddenException extends ApiException {
  const ForbiddenException({
    super.message = 'Access forbidden.',
    super.statusCode = 403,
    super.data,
  });
}

class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'Resource not found.',
    super.statusCode = 404,
    super.data,
  });
}

class BadRequestException extends ApiException {
  const BadRequestException({
    super.message = 'Bad request.',
    super.statusCode = 400,
    super.data,
  });
}

class ServerException extends ApiException {
  const ServerException({
    super.message = 'Internal server error. Please try again later.',
    super.statusCode = 500,
    super.data,
  });
}
