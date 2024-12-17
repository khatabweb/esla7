import 'package:dio/dio.dart';

import '../../../../../core/API/api_error_handler.dart';
import '../../../../../core/API/api_result.dart';
import '../../../../../core/API/api_utility.dart';
import '../../../../../core/API/network_screvies.dart';
import '../model/model.dart';

abstract class AdsPackagesRepo {
  late AdsPackagesModel model;

  static Future<ApiResult<AdsPackagesModel>> getPackages() async {
    try {
      final Response data = await NetworkHelper().request(
          "${ApiUtl.main_owner_api_url}packages",
          method: ServerMethods.GET,
          isUser: false);
      return ApiResult.success(AdsPackagesModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
