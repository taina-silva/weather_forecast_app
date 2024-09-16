import 'package:equatable/equatable.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_property_model.dart';

class WeatherForecastModel extends Equatable {
  final double latitude;
  final double longitude;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final List<DailyWeatherForecastModel> daily;

  const WeatherForecastModel({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.daily,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        timezone,
        timezoneAbbreviation,
        elevation,
        daily,
      ];

  factory WeatherForecastModel.fromMap(Map<String, dynamic> map) {
    final dailyMap = map['daily'] as Map<String, dynamic>?;
    final days = List<String>.from(dailyMap?['time'] ?? []);
    final dailyUnits = map['daily_units'] as Map<String, dynamic>;

    List<DailyWeatherForecastModel> daily = List.generate(days.length, (index) {
      final date = days[index];

      return DailyWeatherForecastModel(
        date: date,
        maxTemperature: WeatherPropertyModel.fromDynamic(
            dailyMap?['temperature_2m_max'][index], dailyUnits['temperature_2m_max']),
        minTemperature: WeatherPropertyModel.fromDynamic(
            dailyMap?['temperature_2m_min'][index], dailyUnits['temperature_2m_min']),
        apparentMaxTemperature: WeatherPropertyModel.fromDynamic(
            dailyMap?['apparent_temperature_max'][index], dailyUnits['apparent_temperature_max']),
        apparentMinTemperature: WeatherPropertyModel.fromDynamic(
            dailyMap?['apparent_temperature_min'][index], dailyUnits['apparent_temperature_min']),
        precipationSum: WeatherPropertyModel.fromDynamic(
            dailyMap?['precipitation_sum'][index], dailyUnits['precipitation_sum']),
        rainSum:
            WeatherPropertyModel.fromDynamic(dailyMap?['rain_sum'][index], dailyUnits['rain_sum']),
        showersSum: WeatherPropertyModel.fromDynamic(
            dailyMap?['showers_sum'][index], dailyUnits['showers_sum']),
        snowfallSum: WeatherPropertyModel.fromDynamic(
            dailyMap?['snowfall_sum'][index], dailyUnits['snowfall_sum']),
        precipitationProbabilityMax: WeatherPropertyModel.fromDynamic(
            dailyMap?['precipitation_probability_max'][index],
            dailyUnits['precipitation_probability_max']),
        precipitationProbabilityMin: WeatherPropertyModel.fromDynamic(
            dailyMap?['precipitation_probability_min'][index],
            dailyUnits['precipitation_probability_min']),
        precipitationProbabilityMean: WeatherPropertyModel.fromDynamic(
            dailyMap?['precipitation_probability_mean'][index],
            dailyUnits['precipitation_probability_mean']),
        winSpeedMax: WeatherPropertyModel.fromDynamic(
            dailyMap?['wind_speed_10m_max'][index], dailyUnits['wind_speed_10m_max']),
        evapotranspiration: WeatherPropertyModel.fromDynamic(
            dailyMap?['et0_fao_evapotranspiration'][index],
            dailyUnits['et0_fao_evapotranspiration']),
      );
    });

    return WeatherForecastModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
      timezone: map['timezone'],
      timezoneAbbreviation: map['timezone_abbreviation'],
      elevation: map['elevation'],
      daily: daily,
    );
  }
}
