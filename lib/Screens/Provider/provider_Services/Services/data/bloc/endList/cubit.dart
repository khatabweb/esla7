import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../Widgets/helper/cache_helper.dart';
import '../../model/endlist_model.dart';
import '../../repo/sub_end_list_repo.dart';
import 'state.dart';

/// the same cubit and request in "lib\Screens\user\providerProfile\endService"
class EndServiceListCubit extends Cubit<EndServiceListState> {
  EndServiceListCubit() : super(EndServiceListInitState());

  static EndServiceListCubit get(context) => BlocProvider.of(context);

  late EndServiceListModel endListModel ;

  Future<void> endService(int? serviceId) async {
    emit(EndServiceListLoadingState());

    try {
      final ownerId = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);

      FormData formData = FormData.fromMap({
        "owner_id": ownerId,
        "service_id": serviceId,
      });

      final response =
          await SubAndEndListRepo.endServiceList(formData: formData);
      response.when(success: (responseData) {
        endListModel = responseData;
        emit(EndServiceListSuccessState(endListModel: responseData));
      }, failure: (error) {
        emit(EndServiceListErrorState(error.apiErrorModel.message!));
      },);
    } catch (e) {
      print(
          "::::::::::: Owner Details catch error ::::::::::::::${e.toString()}");
      emit(EndServiceListErrorState(e.toString()));
    }
  }
}
