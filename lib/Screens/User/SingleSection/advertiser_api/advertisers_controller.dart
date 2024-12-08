import 'package:dio/dio.dart';
import '../../../../API/api_error_handler.dart';
import '../../../../API/api_result.dart';
import '../../../../API/api_utility.dart';
import '../../../Widgets/helper/network_screvies.dart';
import 'advertisers_model.dart';

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
