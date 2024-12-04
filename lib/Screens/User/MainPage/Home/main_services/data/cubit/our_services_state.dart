part of 'our_services_cubit.dart';

sealed class OurServicesState extends Equatable {
  const OurServicesState();

  @override
  List<Object> get props => [];
}

final class OurServicesInitial extends OurServicesState {}

final class OurServicesLoading extends OurServicesState {}

final class OurServicesSuccess extends OurServicesState {
  final MainServicesModel ourServicesModel;
  const OurServicesSuccess({required this.ourServicesModel});
}

final class OurServicesError extends OurServicesState {
  final String error;
  const OurServicesError({required this.error});
}
