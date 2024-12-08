import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/ProviderProfile/Profile/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class OwnerProfileRepo {
  static Future<ApiResult<OwnerProfileModel>> getOwnerProfile() async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_owner_api_url}ownerdetails",
        method: ServerMethods.GET,
        isUser: false,
      );
      return ApiResult.success(OwnerProfileModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
