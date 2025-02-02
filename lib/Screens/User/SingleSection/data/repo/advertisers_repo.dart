import 'package:dio/dio.dart';
import '../../../../../core/API/api_error_handler.dart';
import '../../../../../core/API/api_result.dart';
import '../../../../../core/API/api_utility.dart';
import '../../../../../core/API/network_screvies.dart';
import '../model/advertisers_model.dart';

class AdvertisersRepo {
  static Future<ApiResult<AdvertisersModel>> getAdvertisers() async {
    try {
      Response response = await NetworkHelper().request(
        "${ApiUtl.main_api_url}advertisers",
        method: ServerMethods.GET,
      );
      return ApiResult.success(AdvertisersModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
