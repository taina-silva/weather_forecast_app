import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';

class FetchPositionFromCityFailure extends Failure {
  final String city;

  const FetchPositionFromCityFailure([
    this.city = '',
  ]) : super('Error fetching position from city: $city');

  @override
  List<Object> get props => [message];
}

class FetchWeatherFailure extends Failure {
  final PositionModel? position;

  FetchWeatherFailure([
    this.position,
  ]) : super(
            'Error fetching weather for position - lat:${position?.latitude}, long:${position?.longitude}');

  @override
  List<Object> get props => [message];
}
