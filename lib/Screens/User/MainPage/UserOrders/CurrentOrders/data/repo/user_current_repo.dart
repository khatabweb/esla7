import 'package:dio/dio.dart';
import '../../../../../../../API/api_error_handler.dart';
import '../../../../../../../API/api_result.dart';
import '../../../../../../../API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../Widgets/helper/network_screvies.dart';

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
