part of 'user_current_cubit.dart';

sealed class UserCurrentState extends Equatable {
  const UserCurrentState();

  @override
  List<Object> get props => [];
}

final class UserCurrentInitial extends UserCurrentState {}
final class UserCurrentLoading extends UserCurrentState {}
final class UserCurrentError extends UserCurrentState {
  final String error;
  const UserCurrentError(this.error);
}
final class UserCurrentSuccess extends UserCurrentState {
  final UserCurrentModel model;
  const UserCurrentSuccess(this.model);
}
