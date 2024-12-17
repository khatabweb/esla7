import 'package:equatable/equatable.dart';
import '../repo/ads_packages_repo.dart';
import '../model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ads_packages_state.dart';

class AdsPackagesCubit extends Cubit<AdsPackagesState> {
  AdsPackagesCubit() : super(AdsPackagesInitial());
  static AdsPackagesCubit get(context) => BlocProvider.of(context);

  late AdsPackagesModel adsPackagesModel;
  Future<void> getAdsPackages() async {
    emit(AdsPackagesLoading());
    final response = await AdsPackagesRepo.getPackages();
    response.when(success: (success) {
      adsPackagesModel = success;
      emit(AdsPackagesSuccess(adsPackagesModel: success));
    }, failure: (failure) {
      emit(AdsPackagesError(error: failure.apiErrorModel.message!));
    });
  }
}
