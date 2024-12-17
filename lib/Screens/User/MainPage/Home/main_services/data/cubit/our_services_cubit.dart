import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/model.dart';
import '../repo/controller.dart';

part 'our_services_state.dart';

class OurServicesCubit extends Cubit<OurServicesState> {
  OurServicesCubit() : super(OurServicesInitial());
  late MainServicesModel ourServicesModelCubit;
  void getServices() async {
    emit(OurServicesLoading());
    final response = await MainServicesRepo.getServices();
    response.when(success: (mainServicesModel) {
      ourServicesModelCubit = mainServicesModel;
      emit(OurServicesSuccess(ourServicesModel: mainServicesModel));
    }, failure: (error) {
      emit(OurServicesError(error: error.apiErrorModel.message!));
    });
  }
}
