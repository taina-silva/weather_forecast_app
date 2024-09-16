import 'package:weather_forecast_app/app/core/states/general_state.dart';

class GetLocationsState extends GeneralState {}

class GetLocationsInitialState extends GeneralInitialState implements GetLocationsState {}

class GetLocationsLoadingState extends GeneralLoadingState implements GetLocationsState {}

class GetLocationsSuccessState extends GeneralSuccessState implements GetLocationsState {}

class GetLocationsErrorState extends GeneralErrorState implements GetLocationsState {
  @override
  final String message;
  GetLocationsErrorState(this.message) : super(message);
}
