import 'package:dio/dio.dart';

import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../../../../../../../core/API/network_screvies.dart';
import '../model/sub_service_model.dart';

abstract class SubServiceRepo {
  static Future<ApiResult<SubServiceModel>> ownerSubService(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.owner_sub_service,
        body: formData,
        method: ServerMethods.POST,
        isUser: false,
      );
      return ApiResult.success(SubServiceModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
