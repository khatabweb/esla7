part of 'user_current_cubit.dart';

sealed class providerCurrentState extends Equatable {
  const providerCurrentState();

  @override
  List<Object> get props => [];
}

final class ProviderCurrentInitial extends providerCurrentState {}

final class ProviderCurrentError extends providerCurrentState {
  final String message;
  const ProviderCurrentError(this.message);
}

final class ProviderCurrentLoading extends providerCurrentState {}

final class ProviderCurrentSuccess extends providerCurrentState {
  final OwnerCurrentModel ownerCurrentModel;
  const ProviderCurrentSuccess(this.ownerCurrentModel);
}
