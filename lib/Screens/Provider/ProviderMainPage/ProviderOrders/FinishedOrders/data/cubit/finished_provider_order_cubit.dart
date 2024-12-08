import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/ProviderOrders/FinishedOrders/data/model/model.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/ProviderOrders/FinishedOrders/data/repo/user_finished_repo.dart';

part 'finished_provider_order_state.dart';

class FinishedProviderOrderCubit extends Cubit<FinishedProviderOrderState> {
  FinishedProviderOrderCubit() : super(FinishedProviderOrderInitial());

  late OwnerFinishedModel ownerFinishedModel;

  Future<void> getFinishedOrders() async {
    emit(FinishedProviderOrderLoading());
    final response = await UserFinishedProviderRepo.getFinishedOrders();
    response.when(success: (success) {
      ownerFinishedModel = success;
      emit(FinishedProviderOrderSuccess(ownerFinishedModel));
    }, failure: (failure) {
      emit(FinishedProviderOrderError(failure.apiErrorModel.message!));
    });
  }
}
