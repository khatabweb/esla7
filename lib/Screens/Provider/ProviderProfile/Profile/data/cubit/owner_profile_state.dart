part of 'owner_profile_cubit.dart';

sealed class OwnerProfileState extends Equatable {
  const OwnerProfileState();

  @override
  List<Object> get props => [];
}

final class OwnerProfileInitial extends OwnerProfileState {}

final class OwnerProfileLoading extends OwnerProfileState {}

final class OwnerProfileSuccess extends OwnerProfileState {
  final OwnerProfileModel ownerProfileModel;
  const OwnerProfileSuccess(this.ownerProfileModel);
}

final class OwnerProfileError extends OwnerProfileState {
  final String message;
  const OwnerProfileError(this.message);
}
