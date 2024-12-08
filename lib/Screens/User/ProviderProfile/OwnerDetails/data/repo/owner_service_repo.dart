import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/helper/network_screvies.dart';
import '../model/owner_details_model.dart';

abstract class OwnerServiceRepo {
  static Future<ApiResult<OwnerDetailsModel>> getOwnerService() async {
    try {
      final Response response = await NetworkHelper().request(
          "${ApiUtl.main_api_url}owner/ownermainservice",
          method: ServerMethods.GET);
      return ApiResult.success(OwnerDetailsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  static Future<ApiResult<OwnerDetailsModel>> ownerDetails(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.owner_details,
          method: ServerMethods.POST,
          body: formData);

      if (response.data["status"] == "success") {
        return ApiResult.success(OwnerDetailsModel.fromJson(response.data));
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data["message"]));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
