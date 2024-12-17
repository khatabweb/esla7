import 'package:dio/dio.dart';

import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../../../../../../core/API/network_screvies.dart';
import '../model/model.dart';

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
