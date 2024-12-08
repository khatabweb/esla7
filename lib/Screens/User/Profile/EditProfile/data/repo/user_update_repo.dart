import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Profile/EditProfile/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class UserUpdateRepo {
  static Future<ApiResult<UserUpdateModel>> updateUser(
      {required String userID, required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.user_update_data}$userID",
        method: ServerMethods.POST,
        body: formData,
      );
      if (response.data["status"] == "success") {
        return ApiResult.success(UserUpdateModel.fromJson(response.data));
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data["message"]));
      }
    } catch (error) {
      print("::::::::::: User Update catch error ::::::::::::::");
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
