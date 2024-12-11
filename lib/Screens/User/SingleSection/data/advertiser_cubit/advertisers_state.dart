part of 'advertisers_cubit.dart';

sealed class AdvertisersState extends Equatable {
  const AdvertisersState();

  @override
  List<Object> get props => [];
}

final class AdvertisersInitial extends AdvertisersState {}

final class AdvertisersLoading extends AdvertisersState {}

final class AdvertisersError extends AdvertisersState {
  final String message;
  const AdvertisersError(this.message);
}

final class AdvertisersSuccess extends AdvertisersState {
  final AdvertisersModel advertisersModel;
  const AdvertisersSuccess(this.advertisersModel);
}
