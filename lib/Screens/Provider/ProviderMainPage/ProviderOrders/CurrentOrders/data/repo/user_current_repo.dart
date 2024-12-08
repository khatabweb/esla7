import 'package:dio/dio.dart';

import '../../../../../../../API/api_error_handler.dart';
import '../../../../../../../API/api_result.dart';
import '../../../../../../Widgets/helper/network_screvies.dart';
import '../model/model.dart';

abstract class UserCurrentRepo {
  static Future<ApiResult<OwnerCurrentModel>> getUserCurrentOrders() async {
    try {
      final Response response = await NetworkHelper().request(
        "owner/current-owner-orders",
        method: ServerMethods.GET,
        isUser: false,
      );
      return ApiResult.success(OwnerCurrentModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
