import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/ProviderOrders/FinishedOrders/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class UserFinishedProviderRepo {
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
