import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/states/general_state.dart';

class GetWeatherState extends GeneralState<WeatherForecastModel> {}

class GetWeatherInitialState extends GeneralInitialState<WeatherForecastModel>
    implements GetWeatherState {}

class GetWeatherLoadingState extends GeneralLoadingState<WeatherForecastModel>
    implements GetWeatherState {}

class GetWeatherNoConnectionState extends GeneralNoConnectionState<WeatherForecastModel>
    implements GetWeatherState {}

class GetWeatherErrorState extends GeneralErrorState<WeatherForecastModel>
    implements GetWeatherState {
  @override
  final String message;
  GetWeatherErrorState(this.message) : super(message);
}

class GetWeatherSuccessState extends GeneralSuccessState<WeatherForecastModel>
    implements GetWeatherState {
  final WeatherForecastModel weatherForecast;
  GetWeatherSuccessState(this.weatherForecast) : super(weatherForecast);
}
