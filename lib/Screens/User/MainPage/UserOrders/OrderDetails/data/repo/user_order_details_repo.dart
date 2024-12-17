import 'package:dio/dio.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../../core/API/network_screvies.dart';

abstract class UserOrderDetailsRepo {
  static Future<ApiResult<UserOrderDetailsModel>> orderDetails(
      {required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.user_order_details,
          body: formData,
          method: ServerMethods.POST);

      if (response.data["status"] == "success") {
        return ApiResult.success(UserOrderDetailsModel.fromJson(response.data));
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data["status"]));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
