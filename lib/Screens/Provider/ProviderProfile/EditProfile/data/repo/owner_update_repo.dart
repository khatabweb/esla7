import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/ProviderProfile/EditProfile/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/cach_helper.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

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
