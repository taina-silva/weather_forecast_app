import 'package:equatable/equatable.dart';

class PositionModel extends Equatable {
  final double latitude;
  final double longitude;

  const PositionModel({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];

  factory PositionModel.fromMap(Map<String, dynamic> map) {
    return PositionModel(
      latitude: map['lat'],
      longitude: map['lon'],
    );
  }
}
