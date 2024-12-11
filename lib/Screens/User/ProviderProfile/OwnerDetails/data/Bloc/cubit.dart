import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/owner_details_model.dart';
import '../repo/owner_service_repo.dart';
import 'state.dart';

class OwnerDetailsCubit extends Cubit<OwnerDetailsState> {
  OwnerDetailsCubit() : super(OwnerDetailsInitState());

  static OwnerDetailsCubit get(context) => BlocProvider.of(context);

  // int? ownerId;
  late OwnerDetailsModel ownerDetailsModelCubit;

  Future<void> ownerDetails({required int ownerId}) async {
    emit(OwnerDetailsLoadingState());

    try {
      FormData formData = FormData.fromMap({
        "id": ownerId,
      });

      final response = await OwnerServiceRepo.ownerDetails(formData: formData);

      response.when(success: (ownerDetailsModel) {
        ownerDetailsModelCubit = ownerDetailsModel;
        emit(OwnerDetailsSuccessState(ownerDetailsModel: ownerDetailsModel));
      }, failure: (error) {
        emit(OwnerDetailsErrorState(error.apiErrorModel.message!));
      });
    } catch (e) {
      emit(OwnerDetailsErrorState(e.toString()));
    }
  }
}
