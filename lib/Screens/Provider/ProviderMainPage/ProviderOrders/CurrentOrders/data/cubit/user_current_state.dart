part of 'user_current_cubit.dart';

sealed class UserCurrentState extends Equatable {
  const UserCurrentState();

  @override
  List<Object> get props => [];
}

final class UserCurrentInitial extends UserCurrentState {}

final class UserCurrentError extends UserCurrentState {
  final String message;
  const UserCurrentError(this.message);
}

final class UserCurrentLoading extends UserCurrentState {}

final class UserCurrentSuccess extends UserCurrentState {
  final UserCurrentModel userCurrentModel;
  const UserCurrentSuccess(this.userCurrentModel);
}
