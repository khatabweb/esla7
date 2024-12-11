import 'package:dio/dio.dart';
import '../../../../../API/api_error_handler.dart';
import '../../../../../API/api_result.dart';
import '../../../../../API/api_utility.dart';
import '../../../../Widgets/helper/network_screvies.dart';

abstract class CartRepo {
  static Future<ApiResult> addToCart({required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(ApiUtl.user_cart,
          method: ServerMethods.POST, body: formData);
      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
