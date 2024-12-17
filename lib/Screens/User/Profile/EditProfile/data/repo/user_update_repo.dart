import 'package:dio/dio.dart';
import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../core/API/network_screvies.dart';

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
