import 'package:dio/dio.dart';
import '../../../../../../../core/API/network_screvies.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';

abstract class ComplaintsRepo {
  static Future<ApiResult> sendComplaint({required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.complaints_and_suggestions,
          method: ServerMethods.POST,
          body: formData);
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
