import 'package:dio/dio.dart';
import '../../../../../../../API/api_error_handler.dart';
import '../../../../../../../API/api_result.dart';
import '../../../../../../../API/api_utility.dart';

import '../../../../../../Widgets/helper/network_screvies.dart';
import '../model/model.dart';

class MainServicesRepo {
  static Future<ApiResult<MainServicesModel>> getServices() async {
    try {
      Response data = await NetworkHelper().request(
        "${ApiUtl.main_network_url}api/mainservices",
        method: ServerMethods.GET,
      );
      return ApiResult.success(MainServicesModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
