import 'package:dio/dio.dart';
import '../../../../../../../../core/local_storge/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/rate_repo.dart';
import 'state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitState());

  static RateCubit get(context) => BlocProvider.of(context);
  int? rate;
  int? ownerId;

  Future<void> rateOwner() async {
    emit(RateLoadingState());

    try {
      final userId = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);

      print("Rate : $rate");
      print("user ID: $userId");
      print("owner ID: $ownerId");

      FormData formData = FormData.fromMap({
        "rate": rate,
        "user_id": userId,
        "owner_id": ownerId,
      });

      final response = await RateRepo.rateOwner(formData: formData);

      response.when(
        success: (data) => emit(RateSuccessState()),
        failure: (errorHandler) =>
            emit(RateErrorState(errorHandler.apiErrorModel.message!)),
      );
    } catch (e) {
      print("rate catch error :::::::::::::: ${e.toString()}");
      emit(RateErrorState(e.toString()));
    }
  }
}
