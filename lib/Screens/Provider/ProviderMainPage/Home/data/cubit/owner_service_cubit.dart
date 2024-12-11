import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model.dart';
import '../repo/owner_service_repo.dart';

part 'owner_service_state.dart';

class OwnerServiceCubit extends Cubit<OwnerServiceState> {
  OwnerServiceCubit() : super(OwnerServiceInitial());
  static OwnerServiceCubit get(context) => BlocProvider.of(context);

  late OwnerServiceModel ownerServiceModel;

  Future<void> getService() async {
    emit(OwnerServiceLoading());
    final response = await OwnerServiceRepo.getService();
    response.when(success: (ownerServiceModel) {
      ownerServiceModel = ownerServiceModel;
      emit(OwnerServiceSuccess(ownerServiceModel));
    }, failure: (error) {
      emit(OwnerServiceError(error.apiErrorModel.message!));
    });
  }
}
