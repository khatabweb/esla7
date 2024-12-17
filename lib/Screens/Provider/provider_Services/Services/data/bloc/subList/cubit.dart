import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/local_storge/cache_helper.dart';
import '../../model/sublist_model.dart';
import '../../repo/sub_end_list_repo.dart';
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

      final response = await SubAndEndListRepo.subServiceList(
        formData: formData,
      );
      response.when(success: (responseData) {
        subListModel = responseData;
        emit(SubServiceListSuccessState(responseData));
      }, failure: (error) {
        emit(SubServiceListErrorState(error.apiErrorModel.message!));
      });
    } catch (e) {
      print("owner service catch error ::::::::::::::${e.toString()}");
      emit(SubServiceListErrorState(e.toString()));
    }
  }
}
