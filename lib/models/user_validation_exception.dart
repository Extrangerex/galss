class UserValidationException implements Exception {
  final String message;
  final String? field;
  final String code = 'user_validation_exception';
  UserValidationException(this.message, this.field);
}
