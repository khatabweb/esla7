import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/Auth/SignUp/View/component/ServiceType/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

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
