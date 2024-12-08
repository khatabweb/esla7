import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/data/model/ad_terms_model.dart';
import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/data/repo/ad_features_terms_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ad_features_terms_state.dart';

class AdFeaturesTermsCubit extends Cubit<AdFeaturesTermsState> {
  AdFeaturesTermsCubit() : super(AdFeaturesTermsInitial());
  static AdFeaturesTermsCubit get(context) => BlocProvider.of(context);

  late AdFeaturesTermsModel? adFeaturesTermsModel;
  Future<void> getAdFeaturesTerms() async {
    emit(AdFeaturesTermsLoading());
    final response = await AdFeaturesTermsRepo.getAdFeatures();
    response.when(
      success: (data) {
        adFeaturesTermsModel = data;
        emit(AdFeaturesTermsSuccess(
            adFeaturesTermsModel: adFeaturesTermsModel!));
      },
      failure: (error) {
        emit(AdFeaturesTermsError(error: error.apiErrorModel.message!));
      },
    );
  }
}
