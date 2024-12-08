import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/Notification/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class OwnerNotificationRepo {
  static Future<ApiResult<OwnerNotificationModel>> getNotification() async {
    try {
      final Response response = await NetworkHelper().request(
          "${ApiUtl.main_owner_api_url}newownerindex",
          method: ServerMethods.GET);

      return ApiResult.success(OwnerNotificationModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
