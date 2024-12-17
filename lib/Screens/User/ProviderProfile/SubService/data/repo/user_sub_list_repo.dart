import 'package:dio/dio.dart';

import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../../../../../../core/API/network_screvies.dart';
import '../model/model.dart';

abstract class UserSubListRepo {
  static Future<ApiResult<SubListModel>> getUserSubList(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.user_sub_service,
          body: formData,
          method: ServerMethods.POST);
      return ApiResult.success(SubListModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
