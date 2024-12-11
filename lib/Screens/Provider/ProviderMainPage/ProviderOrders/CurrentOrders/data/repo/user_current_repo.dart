import 'package:dio/dio.dart';
import '../../../../../../../API/api_utility.dart';

import '../../../../../../../API/api_error_handler.dart';
import '../../../../../../../API/api_result.dart';
import '../../../../../../Widgets/helper/network_screvies.dart';
import '../model/model.dart';

abstract class ProviderCurrentRepo {
  static Future<ApiResult<OwnerCurrentModel>> getProviderCurrentOrders() async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_owner_api_url}current-owner-orders",
        method: ServerMethods.GET,
        isUser: false,
      );
      return ApiResult.success(OwnerCurrentModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
