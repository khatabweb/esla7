import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/CurrentOrders/data/model/model.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/CurrentOrders/data/repo/user_current_repo.dart';

part 'user_current_state.dart';

class UserCurrentCubit extends Cubit<UserCurrentState> {
  UserCurrentCubit() : super(UserCurrentInitial());

  late UserCurrentModel model;

  Future<void> getCurrent() async {
    emit(UserCurrentLoading());
    final response = await UserCurrentRepo.getCurrentOrders();
    response.when(success: (data) {
      model = data;
      emit(UserCurrentSuccess(model));
    }, failure: (failure) {
      emit(UserCurrentError(failure.apiErrorModel.message!));
    });
  }
}
