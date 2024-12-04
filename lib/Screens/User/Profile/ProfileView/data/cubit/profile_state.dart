part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;

  ProfileSuccess({required this.profileModel});
}

final class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}
