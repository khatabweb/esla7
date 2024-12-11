import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../model/model.dart';
import '../../../../../Widgets/helper/cache_helper.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

abstract class OwnerUpdateRepo {
  static Future<ApiResult<OwnerUpdateModel>> ownerUpdate(
      {required formData}) async {
    try {
      final ownerID = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);

      final Response response = await NetworkHelper().request(
        "${ApiUtl.owner_update_profile}$ownerID",
        body: formData,
        method: ServerMethods.POST,
        isUser: false,
      );
      if (response.data["status"] == "success") {
        return ApiResult.success(OwnerUpdateModel.fromJson(response.data));
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
