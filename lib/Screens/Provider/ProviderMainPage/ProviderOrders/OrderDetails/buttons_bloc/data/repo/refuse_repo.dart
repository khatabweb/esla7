import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class RefuseRepo {
  static Future<ApiResult> refuseOrder({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.owner_refuse_order,
          body: formData,
          method: ServerMethods.POST);
      if (response.data["status"] == "success") {
        return ApiResult.success(response.data);
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
