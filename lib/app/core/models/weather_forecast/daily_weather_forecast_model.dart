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

  factory DailyWeatherForecastModel.fromMap(Map<String, dynamic> map) {
    return DailyWeatherForecastModel(
      date: map['date'],
      maxTemperature: WeatherPropertyModel.fromMap(map['maxTemperature']),
      minTemperature: WeatherPropertyModel.fromMap(map['minTemperature']),
      apparentMaxTemperature: WeatherPropertyModel.fromMap(map['apparentMaxTemperature']),
      apparentMinTemperature: WeatherPropertyModel.fromMap(map['apparentMinTemperature']),
      precipationSum: WeatherPropertyModel.fromMap(map['precipationSum']),
      rainSum: WeatherPropertyModel.fromMap(map['rainSum']),
      showersSum: WeatherPropertyModel.fromMap(map['showersSum']),
      snowfallSum: WeatherPropertyModel.fromMap(map['snowfallSum']),
      precipitationProbabilityMax: WeatherPropertyModel.fromMap(map['precipitationProbabilityMax']),
      precipitationProbabilityMin: WeatherPropertyModel.fromMap(map['precipitationProbabilityMin']),
      precipitationProbabilityMean:
          WeatherPropertyModel.fromMap(map['precipitationProbabilityMean']),
      winSpeedMax: WeatherPropertyModel.fromMap(map['winSpeedMax']),
      evapotranspiration: WeatherPropertyModel.fromMap(map['evapotranspiration']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'maxTemperature': maxTemperature.toMap(),
      'minTemperature': minTemperature.toMap(),
      'apparentMaxTemperature': apparentMaxTemperature.toMap(),
      'apparentMinTemperature': apparentMinTemperature.toMap(),
      'precipationSum': precipationSum.toMap(),
      'rainSum': rainSum.toMap(),
      'showersSum': showersSum.toMap(),
      'snowfallSum': snowfallSum.toMap(),
      'precipitationProbabilityMax': precipitationProbabilityMax.toMap(),
      'precipitationProbabilityMin': precipitationProbabilityMin.toMap(),
      'precipitationProbabilityMean': precipitationProbabilityMean.toMap(),
      'winSpeedMax': winSpeedMax.toMap(),
      'evapotranspiration': evapotranspiration.toMap(),
    };
  }
}
