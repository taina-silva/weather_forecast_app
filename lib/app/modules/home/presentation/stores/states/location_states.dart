import 'package:weather_forecast_app/app/core/states/general_state.dart';

sealed class GetLocationsState extends GeneralState {}

final class GetLocationsInitialState extends GetLocationsState {}

final class GetLocationsLoadingState extends GetLocationsState {}

final class GetLocationsSuccessState extends GetLocationsState {}

final class GetLocationsErrorState extends GetLocationsState {
  final String message;
  GetLocationsErrorState(this.message);
}
