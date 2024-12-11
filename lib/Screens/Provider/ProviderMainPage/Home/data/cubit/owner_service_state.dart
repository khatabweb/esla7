part of 'owner_service_cubit.dart';

sealed class OwnerServiceState extends Equatable {
  const OwnerServiceState();

  @override
  List<Object> get props => [];
}

final class OwnerServiceInitial extends OwnerServiceState {}

final class OwnerServiceLoading extends OwnerServiceState {}

final class OwnerServiceSuccess extends OwnerServiceState {
  final OwnerServiceModel ownerServiceModel;
  const OwnerServiceSuccess(this.ownerServiceModel);
}

final class OwnerServiceError extends OwnerServiceState {
  final String error;
  const OwnerServiceError(this.error);
}
