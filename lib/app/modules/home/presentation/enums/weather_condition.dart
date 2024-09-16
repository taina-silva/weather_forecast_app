import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
  stormy,
  snowy,
  foggy,
  windy;

  String get name {
    switch (this) {
      case WeatherCondition.sunny:
        return 'Sunny';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.rainy:
        return 'Rainy';
      case WeatherCondition.stormy:
        return 'Stormy';
      case WeatherCondition.snowy:
        return 'Snowy';
      case WeatherCondition.foggy:
        return 'Foggy';
      case WeatherCondition.windy:
        return 'Windy';
      default:
        throw Exception('Unknown weather condition');
    }
  }

  String get iconPath {
    switch (this) {
      case WeatherCondition.sunny:
        return '${Assets.icons}/sunny.png';
      case WeatherCondition.cloudy:
        return '${Assets.icons}/cloudy.png';
      case WeatherCondition.rainy:
        return '${Assets.icons}/rainy.png';
      case WeatherCondition.stormy:
        return '${Assets.icons}/stormy.png';
      case WeatherCondition.snowy:
        return '${Assets.icons}/snowy.png';
      case WeatherCondition.foggy:
        return '${Assets.icons}/foggy.png';
      case WeatherCondition.windy:
        return '${Assets.icons}/windy.png';
      default:
        throw Exception('Unknown weather condition');
    }
  }
}

WeatherCondition determineWeatherCondition(DailyWeatherForecastModel forecast) {
  if (double.parse(forecast.precipationSum.value) > 0) {
    if (double.parse(forecast.snowfallSum.value) > 0) {
      return WeatherCondition.snowy;
    }
    return WeatherCondition.rainy;
  } else if (double.parse(forecast.precipitationProbabilityMax.value) > 50) {
    return WeatherCondition.stormy;
  } else if (double.parse(forecast.showersSum.value) > 0) {
    return WeatherCondition.rainy;
  } else if (double.parse(forecast.maxTemperature.value) > 25) {
    return WeatherCondition.sunny;
  } else if (double.parse(forecast.maxTemperature.value) < 0) {
    return WeatherCondition.snowy;
  } else if (double.parse(forecast.evapotranspiration.value) > 10) {
    return WeatherCondition.windy;
  } else {
    return WeatherCondition.cloudy;
  }
}
