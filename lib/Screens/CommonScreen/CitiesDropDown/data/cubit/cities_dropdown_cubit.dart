import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/cities_model.dart';
import '../repo/cities_repo.dart';

part 'cities_dropdown_state.dart';

class CitiesDropdownCubit extends Cubit<CitiesDropdownState> {
  CitiesDropdownCubit() : super(CitiesDropdownInitial());
  late CitiesModel citiesModelCubit;
  Future<void> getCities() async {
    emit(CitiesDropdownLoading());
    final response = await CitiesRepo.getCities();
    response.when(
      success: (citiesModel) {
        citiesModelCubit = citiesModel;
        emit(CitiesDropdownSuccess(citiesModel: citiesModel));
      },
      failure: (failure) =>
          emit(CitiesDropdownError(message: failure.apiErrorModel.message!)),
    );
  }
}
