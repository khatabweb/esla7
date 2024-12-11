import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import 'state.dart';
import '../../../../Widgets/helper/cache_helper.dart';
import '../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerVerifyCubit extends Cubit<OwnerVerifyState> {
  OwnerVerifyCubit() : super(OwnerVerifyInitState());

  static OwnerVerifyCubit get(context) => BlocProvider.of(context);
  String? code;

  Future<void> ownerVerify() async {
    emit(OwnerVerifyLoadingState());

    try {
      print("confirm code : $code");

      // final ownerId = _pref.getInt("owner_id");
      // ! mabey need to change to String
      final ownerId = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);

      FormData formData = FormData.fromMap({
        "owner_id": ownerId,
        "code": code,
      });

      // final Response response = await dio.post(ApiUtl.owner_verify, data: formData);
      final Response response = await NetworkHelper().request(
          ApiUtl.owner_verify,
          method: ServerMethods.POST,
          body: formData);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        emit(OwnerVerifySuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: owner Verify error ::::::::::::::");
        emit(OwnerVerifyErrorState(response.data["message"]));
      }
    } catch (e) {
      print("owner Verify Catch error :::::::::: ${e.toString()}");
      emit(OwnerVerifyErrorState(e.toString()));
    }
  }
}
