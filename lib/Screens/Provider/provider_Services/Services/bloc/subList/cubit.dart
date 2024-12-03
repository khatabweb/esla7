import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'state.dart';


/// the same cubit and request in "lib\Screens\user\providerProfile\subService"
class SubServiceListCubit extends Cubit<SubServiceListState>{
  SubServiceListCubit() : super(SubServiceListInitState());

  static SubServiceListCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  SubServiceListModel subListModel = SubServiceListModel();

  Future<void> subService() async {
    emit(SubServiceListLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final ownerId = _pref.getInt("owner_id");

      print("Owner ID: $ownerId");

      FormData formData = FormData.fromMap({
        "owner_id" : ownerId,
      });

      final Response response = await dio.post(ApiUtl.user_sub_service, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        subListModel = SubServiceListModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(SubServiceListSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: owner service error ::::::::::::::");
        emit(SubServiceListErrorState(response.data["message"]));
      }
    }catch(e){
      print("owner service catch error ::::::::::::::${e.toString()}");
      emit(SubServiceListErrorState(e.toString()));
    }
  }
}