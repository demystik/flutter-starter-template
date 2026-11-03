abstract class ApiEndpoints {
  /// Base API URL (replace with your backend URL or environment variable)
  static const String baseUrl = 'https://api.example.com/v1';

  /// Timeout Configurations
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // ── Sample Endpoints ───────────────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String userProfile = '/users/me';
}
