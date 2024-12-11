import 'package:dio/dio.dart';
import '../../../../../API/api_error_handler.dart';
import '../../../../../API/api_result.dart';
import '../../../../../API/api_utility.dart';
import '../../../../Widgets/helper/network_screvies.dart';

abstract class CheckoutRepo {
  static Future<ApiResult> checkout({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.user_checkout,
          body: formData,
          method: ServerMethods.POST);
      if (response.data["status"] == "success") {
        return ApiResult.success(response.data);
      } else {
        return ApiResult.failure(response.data["message"]);
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
