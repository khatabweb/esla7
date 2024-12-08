import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import 'state.dart';
import '../../../../Widgets/helper/app_storg.dart';
import '../../../../Widgets/helper/cach_helper.dart';
import '../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';


class OwnerLoginCubit extends Cubit<OwnerLoginState>{
  OwnerLoginCubit() : super(OwnerLoginInitState());

  static OwnerLoginCubit get(context) => BlocProvider.of(context);
  GetStorage box =GetStorage();
  String? phone, password;

  Future<void> ownerLogin() async {
    emit(OwnerLoginLoadingState());

    try{

      print("phone: $phone");
      print("password: $password");

      FormData formData = FormData.fromMap({
        "phone" : "966$phone",
        "password" : password,
        "google_token" : CacheHelper.instance!.getData(key:"owner_google_token", valueType: ValueType.string),
      });

      // final Response response = await dio.post(ApiUtl.owner_login, data: formData);
      final Response response = await NetworkHelper().request(ApiUtl.owner_login, body: formData);
      if(response.statusCode == 200 && response.data["status"] == "success"){
        CacheHelper.instance!.setData("owner_token",value: response.data["access_token"]as String);
        CacheHelper.instance!.setData("owner_id", value :response.data["owner_id"] as int);
        AppStorage.cacheOwnerId(response.data["owner_id"]);
        print(response.data["owner_id"]);
        CacheHelper.instance!.setData("type",value: response.data["type"] as String);
        print(response.data);
        emit(OwnerLoginSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: owner Login error ::::::::::::::");
        emit(OwnerLoginErrorState(response.data["message"]));
      }else if(response.statusCode == 200 && response.data["error"] == "check your data"){
        print("::::::::::: owner Login error ::::::::::::::");
        emit(OwnerLoginErrorState(response.data["error"]));
      }
    }catch(e){
      print("owner Login catch error :::::::: ${e.toString()}");
      emit(OwnerLoginErrorState(e.toString()));
    }
  }
}