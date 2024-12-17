import 'package:dio/dio.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../../core/API/network_screvies.dart';

abstract class UserCurrentRepo {
  static Future<ApiResult<UserCurrentModel>> getCurrentOrders() async {
    try {
      final Response response = await NetworkHelper().request(
        method: ServerMethods.GET,
        "${ApiUtl.main_api_url}current_orders",
      );
      return ApiResult.success(UserCurrentModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
