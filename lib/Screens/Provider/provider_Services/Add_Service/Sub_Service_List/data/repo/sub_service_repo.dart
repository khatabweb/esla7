import 'package:dio/dio.dart';

import '../../../../../../../API/api_error_handler.dart';
import '../../../../../../../API/api_result.dart';
import '../../../../../../../API/api_utility.dart';
import '../../../../../../Widgets/helper/network_screvies.dart';
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
