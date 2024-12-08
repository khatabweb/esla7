import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/CurrentOrders/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class UserCurrentRepo {
  static Future<ApiResult<UserCurrentModel>> getCurrentOrders() async {
    try {
      final Response response = await NetworkHelper().request(
        method: ServerMethods.GET,
        "${ApiUtl.main_owner_api_url}api/current_orders",
      );
      return ApiResult.success(UserCurrentModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
