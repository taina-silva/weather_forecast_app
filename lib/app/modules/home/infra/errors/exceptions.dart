class FetchPositionFromLocationException implements Exception {
  final String? message;

  const FetchPositionFromLocationException(
      {this.message = 'Error fetching position from location'});

  @override
  String toString() => 'FetchPositionFromLocationException(message: $message)';
}

class FetchWeatherException implements Exception {
  final String? message;

  const FetchWeatherException({this.message = 'Error fetching weather'});

  @override
  String toString() => 'FetchWeatherException(message: $message)';
}

class FetchFavoriteLocationsException implements Exception {
  final String? message;

  const FetchFavoriteLocationsException({this.message = 'Error fetching favorite locations'});

  @override
  String toString() => 'FetchFavoriteLocationsException(message: $message)';
}

class FetchFavoriteLocationDetailedException implements Exception {
  final String? message;

  const FetchFavoriteLocationDetailedException(
      {this.message = 'Error fetching favorite location detailed'});

  @override
  String toString() => 'FetchFavoriteLocationDetailedException(message: $message)';
}

class AddFavoriteLocationException implements Exception {
  final String? message;

  const AddFavoriteLocationException({this.message = 'Error adding favorite location'});

  @override
  String toString() => 'AddFavoriteLocationException(message: $message)';
}

class RemoveFavoriteLocationException implements Exception {
  final String? message;

  const RemoveFavoriteLocationException({this.message = 'Error removing favorite location'});

  @override
  String toString() => 'RemoveFavoriteLocationException(message: $message)';
}
