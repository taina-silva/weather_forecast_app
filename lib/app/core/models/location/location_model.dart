import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String? city;
  final String? country;

  const LocationModel({
    required this.city,
    required this.country,
  });

  @override
  List<Object?> get props => [city, country];
}
