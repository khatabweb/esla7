import 'package:dio/dio.dart';
import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../core/API/network_screvies.dart';

abstract class OwnerNotificationRepo {
  static Future<ApiResult<OwnerNotificationModel>> getNotification() async {
    try {
      final Response response = await NetworkHelper().request(
        // "${ApiUtl.main_owner_api_url}newownerindex",
        "${ApiUtl.main_owner_api_url}nots",
        method: ServerMethods.GET,
        isUser: false,
      );

      return ApiResult.success(OwnerNotificationModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
