import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../User/MainPage/UserOrders/CurrentOrders/data/model/model.dart';
import '../../../../../../User/MainPage/UserOrders/CurrentOrders/data/repo/user_current_repo.dart';

part 'user_current_state.dart';

class UserCurrentCubit extends Cubit<UserCurrentState> {
  UserCurrentCubit() : super(UserCurrentInitial());

  static UserCurrentCubit get(context) => BlocProvider.of(context);
  late UserCurrentModel ownerCurrentModel;
  Future<void> getCurrent() async {
    emit(UserCurrentLoading());
    final response = await UserCurrentRepo.getCurrentOrders();
    response.when(success: (success) {
      ownerCurrentModel = success;
      emit(UserCurrentSuccess(success));
    }, failure: (failure) {
      emit(UserCurrentError(failure.apiErrorModel.message!));
    });
  }
}
