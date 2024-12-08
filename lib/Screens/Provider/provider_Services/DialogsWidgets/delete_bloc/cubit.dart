import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import '../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class DeleteServiceCubit extends Cubit<DeleteServiceState> {
  DeleteServiceCubit() : super(DeleteServiceInitState());

  static DeleteServiceCubit get(context) => BlocProvider.of(context);

  Future<void> deleteService(int? endServiceId) async {
    emit(DeleteServiceLoadingState());

    try {
      print("end service id : $endServiceId");

      final Response response = await NetworkHelper().request(
          "${ApiUtl.owner_delete_end_service}$endServiceId",
          method: ServerMethods.POST);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        emit(DeleteServiceSuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("error ::::::::::::::${response.data["message"]}");
        emit(DeleteServiceErrorState(response.data["message"]));
      }
    } catch (e) {
      print("catch error :::::::: ${e.toString()}");
      emit(DeleteServiceErrorState(e.toString()));
    }
  }
}
