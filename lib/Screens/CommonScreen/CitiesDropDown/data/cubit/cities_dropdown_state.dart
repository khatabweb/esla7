part of 'cities_dropdown_cubit.dart';

sealed class CitiesDropdownState extends Equatable {
  const CitiesDropdownState();

  @override
  List<Object> get props => [];
}

final class CitiesDropdownInitial extends CitiesDropdownState {}

final class CitiesDropdownLoading extends CitiesDropdownState {}

final class CitiesDropdownError extends CitiesDropdownState {
  final String message;
  const CitiesDropdownError({required this.message});
}

final class CitiesDropdownSuccess extends CitiesDropdownState {
  final CitiesModel citiesModel;
  const CitiesDropdownSuccess({required this.citiesModel});
}
