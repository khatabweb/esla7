import 'package:dio/dio.dart';

import '../../../../../core/API/api_error_handler.dart';
import '../../../../../core/API/api_result.dart';
import '../../../../../core/API/api_utility.dart';
import '../../../../../core/API/network_screvies.dart';
import '../model/slider_models.dart';

abstract class SliderRepository {
  static Future<ApiResult<SliderModel>> getBanners() async {
    try {
      Response data = await NetworkHelper().request(
        "${ApiUtl.main_api_url}banners",
        method: ServerMethods.GET,
      );
      return ApiResult.success(SliderModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
