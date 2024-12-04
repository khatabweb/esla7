import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esla7/Screens/User/MainPage/Home/main_services/data/model/model.dart';
import 'package:esla7/Screens/User/MainPage/Home/main_services/data/repo/controller.dart';

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
