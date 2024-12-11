import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../model/end_list_model.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

abstract class UserEndListRepo {
  static Future<ApiResult<EndListModel>> getUserEndList(
      {required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.user_end_service,
        method: ServerMethods.POST,
        body: formData,
      );
      if (200 == response.statusCode) {
        return ApiResult.success(EndListModel.fromJson(response.data));
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data['message']));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
