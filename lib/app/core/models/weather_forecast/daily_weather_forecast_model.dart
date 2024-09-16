import 'package:equatable/equatable.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_property_model.dart';

class DailyWeatherForecastModel extends Equatable {
  final String date;
  final WeatherPropertyModel maxTemperature;
  final WeatherPropertyModel minTemperature;
  final WeatherPropertyModel apparentMaxTemperature;
  final WeatherPropertyModel apparentMinTemperature;
  final WeatherPropertyModel precipationSum;
  final WeatherPropertyModel rainSum;
  final WeatherPropertyModel showersSum;
  final WeatherPropertyModel snowfallSum;
  final WeatherPropertyModel precipitationProbabilityMax;
  final WeatherPropertyModel precipitationProbabilityMin;
  final WeatherPropertyModel precipitationProbabilityMean;
  final WeatherPropertyModel winSpeedMax;
  final WeatherPropertyModel evapotranspiration;

  const DailyWeatherForecastModel({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.apparentMaxTemperature,
    required this.apparentMinTemperature,
    required this.precipationSum,
    required this.rainSum,
    required this.showersSum,
    required this.snowfallSum,
    required this.precipitationProbabilityMax,
    required this.precipitationProbabilityMin,
    required this.precipitationProbabilityMean,
    required this.winSpeedMax,
    required this.evapotranspiration,
  });

  @override
  List<Object?> get props => [
        date,
        maxTemperature,
        minTemperature,
        apparentMaxTemperature,
        apparentMinTemperature,
        precipationSum,
        rainSum,
        showersSum,
        snowfallSum,
        precipitationProbabilityMax,
        precipitationProbabilityMin,
        precipitationProbabilityMean,
        winSpeedMax,
        evapotranspiration,
      ];
}
