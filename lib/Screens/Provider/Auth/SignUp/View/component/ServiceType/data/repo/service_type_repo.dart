import 'package:dio/dio.dart';
import '../../../../../../../../../API/api_error_handler.dart';
import '../../../../../../../../../API/api_result.dart';
import '../../../../../../../../../API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../../../Widgets/helper/network_screvies.dart';

abstract class ServiceTypeRepo {
  static Future<ApiResult<ServiceTypeModel>> getServiceType() async {
    try {
      final Response response = await NetworkHelper().request(
          "${ApiUtl.main_api_url}mainservices",
          method: ServerMethods.GET);
      return ApiResult.success(ServiceTypeModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
