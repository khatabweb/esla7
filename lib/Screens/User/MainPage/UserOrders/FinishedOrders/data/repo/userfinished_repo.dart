import 'package:dio/dio.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../../core/API/network_screvies.dart';

abstract class UserFinishedRepo {
  static Future<ApiResult<UserFinishedModel>> getFinished() async {
    try {
      final Response data = await NetworkHelper().request(
          "${ApiUtl.main_api_url}finished_orders",
          method: ServerMethods.GET);
      return ApiResult.success(UserFinishedModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
