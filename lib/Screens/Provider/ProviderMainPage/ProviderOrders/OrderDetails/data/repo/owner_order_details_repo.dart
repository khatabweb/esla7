import 'package:dio/dio.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../model/owner_order_details_model.dart';
import '../../../../../../../core/API/network_screvies.dart';

abstract class OwnerOrderDetailsRepo {
  static Future<ApiResult<OwnerOrderDetailsModel>> getOwnerOrderDetails(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.owner_order_details,
        body: formData,
        isUser: false,
        method: ServerMethods.POST,
      );
      return ApiResult.success(OwnerOrderDetailsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
