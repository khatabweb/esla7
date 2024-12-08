import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import '../model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'state.dart';


class UserEndListCubit extends Cubit<UserEndListState>{
  UserEndListCubit() : super(UserEndListInitState());

  static UserEndListCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  EndListModel endListModel = EndListModel();
  List<CartItemModel> cartItemList = [];

  Future<void> userEndService(int? ownerId, int? serviceId) async {
    emit(UserEndListLoadingState());

    try{
      print("owner ID: $ownerId");
      print("Service ID: $serviceId");

      FormData formData = FormData.fromMap({
        "owner_id" : ownerId,
        "service_id" : serviceId,
      });

      final Response response = await dio.post(ApiUtl.user_end_service, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        endListModel = EndListModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(UserEndListSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(UserEndListErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: Owner Details catch error ::::::::::::::");
      emit(UserEndListErrorState(e.toString()));
    }
  }
}