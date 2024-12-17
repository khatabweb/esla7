import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../API/controller.dart';
import '../model/model.dart';

part 'user_notification_state.dart';

class UserNotificationCubit extends Cubit<UserNotificationState> {
  UserNotificationCubit() : super(UserNotificationInitial());

  late UserNotificationModel userNotificationModelCubit;
  void getNotification() async {
    emit(UserNotificationLoading());
    final response = await UserNotificationRepo.getNotification();
    response.when(
      success: (userNotificationModel) {
        userNotificationModelCubit = userNotificationModel;
        emit(UserNotificationSuccess(
            userNotificationModel: userNotificationModel));
      },
      failure: (error) => emit(
        UserNotificationError(error: error.apiErrorModel.message!),
      ),
    );
  }
}
