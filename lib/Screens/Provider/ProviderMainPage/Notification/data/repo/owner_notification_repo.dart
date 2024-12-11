import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../model/model.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

abstract class OwnerNotificationRepo {
  static Future<ApiResult<OwnerNotificationModel>> getNotification() async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_owner_api_url}newownerindex",
        method: ServerMethods.GET,
        isUser: false,
      );

      return ApiResult.success(OwnerNotificationModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
