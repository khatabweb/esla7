import 'package:dio/dio.dart';
import '../../../../../core/API/api_utility.dart';
import '../../../../../core/local_storge/cache_helper.dart';
import '../../../../../core/API/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class AdsSubscribeCubit extends Cubit<AdsSubscribeState> {
  AdsSubscribeCubit() : super(AdsSubscribeInitState());

  static AdsSubscribeCubit get(context) => BlocProvider.of(context);
  int? packageId;

  Future<void> subscribe() async {
    emit(AdsSubscribeLoadingState());

    try {
      final ownerId = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);

      print("Owner ID: $ownerId");
      print("Package ID: $packageId");

      FormData formData = FormData.fromMap({
        "owner_id": ownerId,
        "package_id": packageId,
      });

      final Response response = await NetworkHelper()
          .request(ApiUtl.owner_ads_subscribe, body: formData);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(AdsSubscribeSuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: State error ::::::::::::::");
        emit(AdsSubscribeErrorState(response.data["message"]));
      }
    } catch (e) {
      print("::::::::::: catch error :::::::::::::: ${e.toString()}");
      emit(AdsSubscribeErrorState(e.toString()));
    }
  }
}
