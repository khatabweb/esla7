part of 'user_finished_cubit.dart';

sealed class UserFinishedState extends Equatable {
  const UserFinishedState();

  @override
  List<Object> get props => [];
}

final class UserFinishedInitial extends UserFinishedState {}

final class UserFinishedLoading extends UserFinishedState {}

final class UserFinishedError extends UserFinishedState {
  final String error;
  const UserFinishedError({required this.error});
}

final class UserFinishedSuccess extends UserFinishedState {
  final UserFinishedModel userFinishedModel;
  const UserFinishedSuccess({required this.userFinishedModel});
}
