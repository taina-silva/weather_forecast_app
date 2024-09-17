import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';

class FetchPositionFromLocationFailure extends Failure {
  final LocationModel? location;

  FetchPositionFromLocationFailure([
    this.location,
  ]) : super(
            'Error fetching position from location${location != null ? ' - ${location.city}, ${location.country}.' : '.'}');

  @override
  List<Object> get props => [message];
}

class FetchWeatherFailure extends Failure {
  final PositionModel? position;

  FetchWeatherFailure([
    this.position,
  ]) : super(
            'Error fetching weather from position${position != null ? ' - lat(${position.latitude}) long(${position.longitude}).' : '.'}');

  @override
  List<Object> get props => [message];
}

class FetchFavoriteLocationsFailure extends Failure {
  const FetchFavoriteLocationsFailure([
    super.message = 'Error fetching favorite locations',
  ]);

  @override
  List<Object> get props => [message];
}

class FetchFavoriteLocationDetailedFailure extends Failure {
  final LocationModel? location;

  FetchFavoriteLocationDetailedFailure({this.location})
      : super(
            'Error fetching favorite location detailed${location != null ? ' - ${location.city}, ${location.country}.' : '.'}');

  @override
  List<Object> get props => [message];
}

class AddFavoriteLocationFailure extends Failure {
  final LocationModel? location;

  AddFavoriteLocationFailure({this.location})
      : super(
            'Error adding favorite location${location != null ? ' - ${location.city}, ${location.country}.' : '.'}');

  @override
  List<Object> get props => [message];
}

class RemoveFavoriteLocationFailure extends Failure {
  final LocationModel? location;

  RemoveFavoriteLocationFailure({this.location})
      : super(
            'Error removing favorite location${location != null ? ' - ${location.city}, ${location.country}.' : '.'}');

  @override
  List<Object> get props => [message];
}
