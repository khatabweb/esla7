import 'package:dio/dio.dart';
import '../../../../../../../core/API/api_error_handler.dart';
import '../../../../../../../core/API/api_result.dart';
import '../../../../../../../core/API/api_utility.dart';
import '../../../../../../../core/API/network_screvies.dart';
import '../model/service_name_model.dart';

abstract class ServiceNameListRepo {
  static Future<ApiResult<ServiceNameModel>> getServiceNameList(
      {required FormData formData}) async {
    try {
      final Response response = await await NetworkHelper().request(
        ApiUtl.owner_end_service,
        body: formData,
        method: ServerMethods.POST,
        isUser: false,
      );
      return ApiResult.success(ServiceNameModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
