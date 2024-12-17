import 'package:dio/dio.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../../../../../../../core/API/network_screvies.dart';

abstract class AddServiceRepo {
  static Future<ApiResult> ownerAddService({required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.owner_add_service,
          body: formData,
          method: ServerMethods.POST,
          isUser: false);
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
