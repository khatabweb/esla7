part of 'user_notification_cubit.dart';

sealed class UserNotificationState extends Equatable {
  const UserNotificationState();

  @override
  List<Object> get props => [];
}

final class UserNotificationInitial extends UserNotificationState {}

final class UserNotificationLoading extends UserNotificationState {}

final class UserNotificationSuccess extends UserNotificationState {
  final UserNotificationModel userNotificationModel;
  const UserNotificationSuccess({required this.userNotificationModel});
}

final class UserNotificationError extends UserNotificationState {
  final String error;
  const UserNotificationError({required this.error});
}
