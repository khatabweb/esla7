import 'package:dio/dio.dart';

import '../../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../../core/API/api_result.dart';
import '../../../../../../../../core/API/api_utility.dart';
import '../../../../../../../../core/API/network_screvies.dart';

abstract class AcceptRepo {
  static Future<ApiResult> acceptOrder({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.owner_accept_order,
        body: formData,
        method: ServerMethods.POST,
        isUser: false,
      );
      if (response.data['status'] == 'success') {
        return ApiResult.success(response.data);
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
