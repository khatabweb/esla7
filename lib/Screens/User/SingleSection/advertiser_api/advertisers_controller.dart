import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';
import 'advertisers_model.dart';

class AdvertisersRepo {
  static Future<ApiResult<AdvertisersModel>> getAdvertisers() async {
    try {
      Response response = await NetworkHelper().request(
        "${ApiUtl.main_api_url}api/advertisers",
        method: ServerMethods.GET,
      );
      return ApiResult.success(AdvertisersModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
