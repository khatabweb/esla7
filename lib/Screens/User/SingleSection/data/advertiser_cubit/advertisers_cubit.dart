import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repo/advertisers_repo.dart';
import '../model/advertisers_model.dart';

part 'advertisers_state.dart';

class AdvertisersCubit extends Cubit<AdvertisersState> {
  AdvertisersCubit() : super(AdvertisersInitial());

  late AdvertisersModel advertisersModel;

  Future<void> getAdvertisers() async {
    emit(AdvertisersLoading());

    final response = await AdvertisersRepo.getAdvertisers();
    response.when(success: (response) {
      advertisersModel = response;
      emit(AdvertisersSuccess(advertisersModel));
    }, failure: (error) {
      emit(AdvertisersError(error.apiErrorModel.message!));
    });
  }
}
