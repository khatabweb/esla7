import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/ProviderOrders/OrderDetails/data/model/owner_order_details_model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class OwnerOrderDetailsRepo {
  static Future<ApiResult<OwnerOrderDetailsModel>> getOwnerOrderDetails(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.owner_order_details,
          body: formData,
          isUser: false,
          method: ServerMethods.POST,);
      return ApiResult.success(OwnerOrderDetailsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
