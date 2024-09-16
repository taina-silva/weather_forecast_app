import 'package:weather_forecast_app/app/core/states/general_state.dart';

class GetFavoriteLocationsState extends GeneralState {}

class GetFavoriteLocationsInitialState extends GeneralInitialState
    implements GetFavoriteLocationsState {}

class GetFavoriteLocationsLoadingState extends GeneralLoadingState
    implements GetFavoriteLocationsState {}

class GetFavoriteLocationsSuccessState extends GeneralSuccessState
    implements GetFavoriteLocationsState {}

class GetFavoriteLocationsErrorState extends GeneralErrorState
    implements GetFavoriteLocationsState {
  @override
  final String message;
  GetFavoriteLocationsErrorState(this.message) : super(message);
}

class ManipulateFavoriteLocationState extends GeneralState {}

class ManipulateFavoriteLocationInitialState extends GeneralInitialState
    implements ManipulateFavoriteLocationState {}

class ManipulateFavoriteLocationLoadingState extends GeneralLoadingState
    implements ManipulateFavoriteLocationState {}

class ManipulateFavoriteLocationSuccessState extends GeneralSuccessWithDataState
    implements ManipulateFavoriteLocationState {
  final String message;
  ManipulateFavoriteLocationSuccessState(this.message) : super(message);
}

class ManipulateFavoriteLocationErrorState extends GeneralErrorState
    implements ManipulateFavoriteLocationState {
  @override
  final String message;
  ManipulateFavoriteLocationErrorState(this.message) : super(message);
}
