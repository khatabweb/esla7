import 'package:equatable/equatable.dart';
import '../model/model.dart';
import '../repo/user_current_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_current_state.dart';

class providerCurrentCubit extends Cubit<providerCurrentState> {
  providerCurrentCubit() : super(ProviderCurrentInitial());

  static providerCurrentCubit get(context) => BlocProvider.of(context);
  late OwnerCurrentModel ownerCurrentModel;
  Future<void> getCurrent() async {
    emit(ProviderCurrentLoading());
    final response = await ProviderCurrentRepo.getProviderCurrentOrders();
    response.when(success: (success) {
      ownerCurrentModel = success;
      emit(ProviderCurrentSuccess(ownerCurrentModel));
    }, failure: (failure) {
      emit(ProviderCurrentError(failure.apiErrorModel.message!));
    });
  }
}
