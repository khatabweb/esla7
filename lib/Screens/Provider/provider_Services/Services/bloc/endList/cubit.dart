import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'state.dart';

/// the same cubit and request in "lib\Screens\user\providerProfile\endService"
class EndServiceListCubit extends Cubit<EndServiceListState>{
  EndServiceListCubit() : super(EndServiceListInitState());

  static EndServiceListCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  EndServiceListModel endListModel = EndServiceListModel();

  Future<void> endService(int? serviceId) async {
    emit(EndServiceListLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final ownerId = _pref.getInt("owner_id");

      print("owner ID: $ownerId");
      print("Service ID: $serviceId");

      FormData formData = FormData.fromMap({
        "owner_id" : ownerId,
        "service_id" : serviceId,
      });

      final Response response = await dio.post(ApiUtl.user_end_service, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        endListModel = EndServiceListModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(EndServiceListSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(EndServiceListErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: Owner Details catch error ::::::::::::::${e.toString()}");
      emit(EndServiceListErrorState(e.toString()));
    }
  }
}