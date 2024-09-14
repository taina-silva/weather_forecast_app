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
}
