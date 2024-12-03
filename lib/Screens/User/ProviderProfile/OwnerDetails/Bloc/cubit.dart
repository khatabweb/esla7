import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/ProviderProfile/OwnerDetails/Bloc/state.dart';
import 'package:esla7/Screens/User/ProviderProfile/OwnerDetails/model/owner_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerDetailsCubit extends Cubit<OwnerDetailsState>{
  OwnerDetailsCubit() : super(OwnerDetailsInitState());

  static OwnerDetailsCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? ownerId;
  OwnerDetailsModel ownerDetailsModel = OwnerDetailsModel();

  Future<void> ownerDetails() async {
    emit(OwnerDetailsLoadingState());

    try{
      print("owner ID: $ownerId");

      FormData formData = FormData.fromMap({
        "id" : ownerId,
      });

      final Response response = await dio.post(ApiUtl.owner_details, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        ownerDetailsModel = OwnerDetailsModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(OwnerDetailsSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(OwnerDetailsErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: Owner Details catch error ::::::::::::::");
      emit(OwnerDetailsErrorState(e.toString()));
    }
  }
}