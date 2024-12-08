part of 'ads_packages_cubit.dart';

sealed class AdsPackagesState extends Equatable {
  const AdsPackagesState();

  @override
  List<Object> get props => [];
}

final class AdsPackagesInitial extends AdsPackagesState {}

final class AdsPackagesLoading extends AdsPackagesState {}

final class AdsPackagesSuccess extends AdsPackagesState {
  final AdsPackagesModel adsPackagesModel;
  const AdsPackagesSuccess({required this.adsPackagesModel});
}

final class AdsPackagesError extends AdsPackagesState {
  final String error;
  const AdsPackagesError({required this.error});
}
