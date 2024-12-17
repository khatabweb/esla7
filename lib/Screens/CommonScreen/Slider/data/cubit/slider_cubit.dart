import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repo/slider_repo.dart';
import '../model/slider_models.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  late SliderModel sliderModelCubit;
  void getSlider() async {
    emit(SliderLoading());
    final response = await SliderRepository.getBanners();
    response.when(
      success: (sliderModel) {
        emit(SliderSuccess(sliderModel: sliderModel));
        sliderModelCubit = sliderModel;
      },
      failure: (errorHandler) =>
          emit(SliderError(error: errorHandler.apiErrorModel.message!)),
    );
  }
}
