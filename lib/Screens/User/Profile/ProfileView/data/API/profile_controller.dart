import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/data/model/profile_model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

abstract class ProfileRepo {
  static Future<ApiResult<ProfileModel>> getUserProfile() async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_network_url}api/user",
        method: ServerMethods.GET,
      );
      return ApiResult.success(ProfileModel.fromJson(response.data));
    } catch (error) {
      print("::::::::::: User Profile catch error ::::::::::::::");
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
