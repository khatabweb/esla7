part of 'service_type_cubit.dart';

sealed class ServiceTypeState extends Equatable {
  const ServiceTypeState();

  @override
  List<Object> get props => [];
}

final class ServiceTypeInitial extends ServiceTypeState {}

final class ServiceTypeLoading extends ServiceTypeState {}

final class ServiceTypeError extends ServiceTypeState {
  final String message;
  const ServiceTypeError(this.message);
}

final class ServiceTypeSuccess extends ServiceTypeState {
  final ServiceTypeModel model;
  const ServiceTypeSuccess(this.model);
}
