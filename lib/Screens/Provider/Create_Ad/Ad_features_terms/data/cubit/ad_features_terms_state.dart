part of 'ad_features_terms_cubit.dart';

sealed class AdFeaturesTermsState extends Equatable {
  const AdFeaturesTermsState();

  @override
  List<Object> get props => [];
}

final class AdFeaturesTermsInitial extends AdFeaturesTermsState {}

final class AdFeaturesTermsError extends AdFeaturesTermsState {
  final String error;
  const AdFeaturesTermsError({required this.error});
}

final class AdFeaturesTermsLoading extends AdFeaturesTermsState {}

final class AdFeaturesTermsSuccess extends AdFeaturesTermsState {
  final AdFeaturesTermsModel adFeaturesTermsModel;
  const AdFeaturesTermsSuccess({required this.adFeaturesTermsModel});
}
