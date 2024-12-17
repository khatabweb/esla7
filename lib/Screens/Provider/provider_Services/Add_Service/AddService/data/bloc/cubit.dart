import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/local_storge/cache_helper.dart';
import '../repo/add_service_repo.dart';
import 'state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitState());

  static AddServiceCubit get(context) => BlocProvider.of(context);
  int? subServiceId;
  int? serviceNameId;
  int? price;
  String? desc;

  Future<void> ownerAddService() async {
    emit(AddServiceLoadingState());

    try {
      final ownerId = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);

      print("Owner ID: $ownerId");
      print("Sub service ID: $subServiceId");
      print("End service ID: $serviceNameId");
      print("Price: $price");
      print("Description: $desc");

      FormData formData = FormData.fromMap({
        "owner_id": ownerId,
        "sub_service_id": subServiceId,
        "end_service_id": serviceNameId,
        "price": price,
        "description": desc,
      });

      final response = await AddServiceRepo.ownerAddService(formData: formData);

      response.when(
        success: (response) => emit(AddServiceSuccessState()),
        failure: (error) => emit(
          AddServiceErrorState(error.apiErrorModel.message!),
        ),
      );
    } catch (e) {
      print("::::::::::: catch error :::::::::::::: ${e.toString()}");
      emit(AddServiceErrorState(e.toString()));
    }
  }
}
