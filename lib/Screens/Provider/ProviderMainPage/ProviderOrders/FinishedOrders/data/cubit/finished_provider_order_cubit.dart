import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/model.dart';
import '../repo/provider_finished_repo.dart';
part 'finished_provider_order_state.dart';

class FinishedProviderOrderCubit extends Cubit<FinishedProviderOrderState> {
  FinishedProviderOrderCubit() : super(FinishedProviderOrderInitial());

  late OwnerFinishedModel ownerFinishedModel;

  Future<void> getFinishedOrders() async {
    emit(FinishedProviderOrderLoading());
    final response = await ProviderFinishedProviderRepo.getFinishedOrders();
    response.when(success: (success) {
      ownerFinishedModel = success;
      emit(FinishedProviderOrderSuccess(ownerFinishedModel));
    }, failure: (failure) {
      emit(FinishedProviderOrderError(failure.apiErrorModel.message!));
    });
  }
}
