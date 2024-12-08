import 'package:dio/dio.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/helper/cach_helper.dart';
import '../../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'state.dart';

/// the same cubit and request in "lib\Screens\user\providerProfile\subService"
class SubServiceListCubit extends Cubit<SubServiceListState> {
  SubServiceListCubit() : super(SubServiceListInitState());

  static SubServiceListCubit get(context) => BlocProvider.of(context);

  SubServiceListModel subListModel = SubServiceListModel();

  Future<void> subService() async {
    emit(SubServiceListLoadingState());

    try {
      final ownerId = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);

      print("Owner ID: $ownerId");

      FormData formData = FormData.fromMap({
        "owner_id": ownerId,
      });

      final Response response = await NetworkHelper().request(
          ApiUtl.user_sub_service,
          body: formData,
          method: ServerMethods.POST);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        subListModel = SubServiceListModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(SubServiceListSuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: owner service error ::::::::::::::");
        emit(SubServiceListErrorState(response.data["message"]));
      }
    } catch (e) {
      print("owner service catch error ::::::::::::::${e.toString()}");
      emit(SubServiceListErrorState(e.toString()));
    }
  }
}
