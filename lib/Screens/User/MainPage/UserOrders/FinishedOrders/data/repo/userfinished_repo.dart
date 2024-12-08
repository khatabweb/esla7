import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/FinishedOrders/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class UserFinishedRepo {
  static Future<ApiResult<UserFinishedModel>> getFinished() async {
    try {
      final Response data = await NetworkHelper().request(
          "${ApiUtl.main_owner_api_url}api/finished_orders",
          method: ServerMethods.GET);
      return ApiResult.success(UserFinishedModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
