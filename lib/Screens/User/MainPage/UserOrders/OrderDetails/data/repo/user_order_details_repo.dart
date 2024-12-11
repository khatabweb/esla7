import 'package:dio/dio.dart';
import '../../../../../../../API/api_error_handler.dart';
import '../../../../../../../API/api_result.dart';
import '../../../../../../../API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../Widgets/helper/network_screvies.dart';

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
