import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'state.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(SearchInitState());

  static SearchCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? name;
  SearchModel searchModel = SearchModel();

  Future<void> searchDetails() async {
    emit(SearchLoadingState());

    try{
      print("name: $name");

      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("user_token");

      dio.options.headers = {
        "Authorization": "Bearer $token",
      };

      FormData formData = FormData.fromMap({
        "name" : name,
      });

      final Response response = await dio.post(ApiUtl.user_search, data: formData);

      if(response.statusCode == 200 && response.data["message"] == "success"){
        print(response.data);
        searchModel = SearchModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(SearchSuccessState());
      }else if(response.statusCode == 200 && response.data["message"] != "success"){
        print("::::::::::: error ::::::::::::::${response.data["message"]}");
        emit(SearchErrorState(response.data["message"]));
      }
    }catch(e){
      print("catch error :::::::::::::: ${e.toString()}");
      emit(SearchErrorState(e.toString()));
    }
  }
}
