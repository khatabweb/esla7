import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../model/profile_model.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

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
