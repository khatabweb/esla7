import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import '../model/slider_models.dart';
import '../../../../../API/api_error_handler.dart';
import '../../../../../API/api_result.dart';
import '../../../../Widgets/helper/network_screvies.dart';

abstract class SliderRepository {
  static Future<ApiResult<SliderModel>> getBanners() async {
    try {
      Response data = await NetworkHelper().request(
        "${ApiUtl.main_network_url}api/banners",
        method: ServerMethods.GET,
      );
      return ApiResult.success(SliderModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
