class InvalidStorageTypeException implements Exception {
  final String message;

  InvalidStorageTypeException(this.message);

  @override
  String toString() => 'InvalidStorageTypeException(message: $message)';
}

class UnsupportedStorageTypeException implements Exception {
  final String message;

  UnsupportedStorageTypeException(this.message);

  @override
  String toString() => 'InvalidStorageTypeException(message: $message)';
}
