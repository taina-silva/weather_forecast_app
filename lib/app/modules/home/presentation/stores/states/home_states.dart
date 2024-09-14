import 'package:equatable/equatable.dart';

sealed class GetCountriesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCountriesInitialState extends GetCountriesState {}

final class GetCountriesLoadingState extends GetCountriesState {}

final class GetCountriesSuccessState extends GetCountriesState {}

final class GetCountriesErrorState extends GetCountriesState {
  final String message;
  GetCountriesErrorState(this.message);
}

sealed class GetCitiesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCitiesInitialState extends GetCitiesState {}

final class GetCitiesLoadingState extends GetCitiesState {}

final class GetCitiesSuccessState extends GetCitiesState {}

final class GetCitiesErrorState extends GetCitiesState {
  final String message;
  GetCitiesErrorState(this.message);
}
