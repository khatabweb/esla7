import 'package:dio/dio.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../../core/API/network_screvies.dart';

abstract class ProviderFinishedProviderRepo {
  static Future<ApiResult<OwnerFinishedModel>> getFinishedOrders() async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_owner_api_url}finished-owner-orders",
        method: ServerMethods.GET,
        isUser: false,
      );
      return ApiResult.success(OwnerFinishedModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
