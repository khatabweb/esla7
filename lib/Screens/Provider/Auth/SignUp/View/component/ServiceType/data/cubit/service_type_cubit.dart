import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/model.dart';
import '../repo/service_type_repo.dart';

part 'service_type_state.dart';

class ServiceTypeCubit extends Cubit<ServiceTypeState> {
  ServiceTypeCubit() : super(ServiceTypeInitial());

  late ServiceTypeModel serviceTypeModel;

  Future<void> getServiceType() async {
    emit(ServiceTypeLoading());
    final response = await ServiceTypeRepo.getServiceType();
    response.when(success: (serviceTypeModel) {
      serviceTypeModel = serviceTypeModel;
      emit(ServiceTypeSuccess(serviceTypeModel));
    }, failure: (error) {
      emit(ServiceTypeError(error.apiErrorModel.message!));
    });
  }
}
