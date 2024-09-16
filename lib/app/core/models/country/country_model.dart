import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final String name;
  final List<String> cities;

  const CountryModel({
    required this.name,
    required this.cities,
  });

  @override
  List<Object?> get props => [name, cities];

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      name: map['country'] as String,
      cities: List<String>.from(map['cities'] as List),
    );
  }
}
