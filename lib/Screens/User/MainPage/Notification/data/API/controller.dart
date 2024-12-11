import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/helper/network_screvies.dart';
import '../model/model.dart';

abstract class UserNotificationRepo {
  static Future<ApiResult<UserNotificationModel>> getNotification() async {
    try {
      Response data = await NetworkHelper().request(
        "${ApiUtl.main_api_url}nots",
        method: ServerMethods.GET,
      );
      return ApiResult.success(UserNotificationModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
