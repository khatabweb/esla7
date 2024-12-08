import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class UpdatePasswordRepo {
  static Future<ApiResult> updatePassword({required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.user_update_password,
        body: formData,
        method: ServerMethods.POST,
      );
      if (response.data["status"] == "success") {
        return ApiResult.success(response.data);
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data["message"]));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }
}
