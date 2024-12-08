import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/FinishedOrders/data/model/model.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/FinishedOrders/data/repo/userfinished_repo.dart';

part 'user_finished_state.dart';

class UserFinishedCubit extends Cubit<UserFinishedState> {
  UserFinishedCubit() : super(UserFinishedInitial());

  Future<void> getFinished() async {
    var data = await UserFinishedRepo.getFinished();
    print(data);
    data.when(success: (data) => emit(UserFinishedSuccess(userFinishedModel: data)), failure: (errorHandler) => emit(UserFinishedError(error: errorHandler.apiErrorModel.message!)),);

    
  }
}
