import 'package:dio/dio.dart';

import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

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
