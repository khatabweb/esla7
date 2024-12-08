part of 'finished_provider_order_cubit.dart';

sealed class FinishedProviderOrderState extends Equatable {
  const FinishedProviderOrderState();

  @override
  List<Object> get props => [];
}

final class FinishedProviderOrderInitial extends FinishedProviderOrderState {}
final class FinishedProviderOrderLoading extends FinishedProviderOrderState {}
final class FinishedProviderOrderError extends FinishedProviderOrderState {
  final String errorMessage;
  const FinishedProviderOrderError(this.errorMessage);
}
final class FinishedProviderOrderSuccess extends FinishedProviderOrderState {
  final OwnerFinishedModel ownerFinishedModel;
  const FinishedProviderOrderSuccess(this.ownerFinishedModel);
}
