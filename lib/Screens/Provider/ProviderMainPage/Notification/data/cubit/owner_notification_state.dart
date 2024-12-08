part of 'owner_notification_cubit.dart';

sealed class OwnerNotificationState extends Equatable {
  const OwnerNotificationState();

  @override
  List<Object> get props => [];
}

final class OwnerNotificationInitial extends OwnerNotificationState {}

final class OwnerNotificationLoading extends OwnerNotificationState {}

final class OwnerNotificationSuccess extends OwnerNotificationState {
  final OwnerNotificationModel ownerNotificationModel;

  OwnerNotificationSuccess({required this.ownerNotificationModel});
}

final class OwnerNotificationError extends OwnerNotificationState {
  final String error;
  const OwnerNotificationError(this.error);
}
