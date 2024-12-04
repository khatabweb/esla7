import 'package:dio/dio.dart';
import 'package:esla7/Screens/User/SingleSection/advertiser_api/advertisers_controller.dart';
import 'package:esla7/Screens/User/SingleSection/advertiser_api/advertisers_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/owners_repo.dart';
import 'model.dart';
import 'state.dart';

class OwnersCubit extends Cubit<OwnersState> {
  OwnersCubit() : super(OwnersInitState());

  static OwnersCubit get(context) => BlocProvider.of(context);
  late OwnerModel ownersModel;
  late AdvertisersModel advertisersModel;

  Future<void> getOwners(int? serviceId) async {
    emit(OwnersLoadingState());
    FormData formData = FormData.fromMap({
      "id": serviceId,
    });
    print("Service ID ::::: $serviceId");
    final response = await OwnersRepo.getOwners(formData: formData);
    response.when(success: (response) {
      ownersModel = response;
      emit(OwnersSuccessState());
    }, failure: (error) {
      emit(OwnersErrorState(error.apiErrorModel.message!));
    });
  }

  Future<void> getAdvertisers() async {
    emit(OwnersLoadingState());

    final response = await AdvertisersRepo.getAdvertisers();
    response.when(success: (response) {
      advertisersModel = response;
      emit(OwnersSuccessState());
    }, failure: (error) {
      emit(OwnersErrorState(error.apiErrorModel.message!));
    });
  }
}
