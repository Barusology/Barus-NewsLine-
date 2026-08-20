sealed class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class ParseException extends AppException {
  const ParseException(super.message);
}

class LaunchUrlException extends AppException {
  const LaunchUrlException(super.message);
}