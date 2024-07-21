class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}
