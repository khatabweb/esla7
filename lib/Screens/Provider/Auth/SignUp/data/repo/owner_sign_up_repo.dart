import 'package:dio/dio.dart';
import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../../../../../../core/API/network_screvies.dart';

abstract class OwnerSignUpRepo {
  static Future<ApiResult> signUp({required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.owner_register,
          body: formData,
          method: ServerMethods.POST);
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
