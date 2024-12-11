import 'package:dio/dio.dart';

import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/helper/network_screvies.dart';
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
