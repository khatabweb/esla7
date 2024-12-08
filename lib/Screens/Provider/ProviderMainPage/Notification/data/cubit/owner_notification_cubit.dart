import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/model.dart';
import '../repo/owner_notification_repo.dart';
part 'owner_notification_state.dart';

class OwnerNotificationCubit extends Cubit<OwnerNotificationState> {
  OwnerNotificationCubit() : super(OwnerNotificationInitial());
  static OwnerNotificationCubit get(context) => BlocProvider.of(context);
  late OwnerNotificationModel ownerNotificationModel;
  Future<void> getNotification() async {
    emit(OwnerNotificationLoading());
    final response = await OwnerNotificationRepo.getNotification();
    response.when(success: (success) {
      ownerNotificationModel = success;
      emit(OwnerNotificationSuccess(ownerNotificationModel: success));
    }, failure: (failure) {
      emit(OwnerNotificationError(failure.apiErrorModel.message!));
    });
  }
}
