import 'package:equatable/equatable.dart';

class WeatherPropertyModel extends Equatable {
  final String value;
  final String unit;

  const WeatherPropertyModel({
    required this.value,
    required this.unit,
  });

  @override
  List<Object?> get props => [value, unit];

  factory WeatherPropertyModel.fromDynamic(dynamic value, String unit) {
    return WeatherPropertyModel(
      value: value.toString(),
      unit: unit,
    );
  }
}
