import 'package:equatable/equatable.dart';

class FetchPositionFromCityException extends Equatable implements Exception {
  final String? message;

  const FetchPositionFromCityException({this.message = 'Error fetching position from city'});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}


class FetchWeatherException extends Equatable implements Exception {
  final String? message;

  const FetchWeatherException({this.message = 'Error fetching weather'});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}