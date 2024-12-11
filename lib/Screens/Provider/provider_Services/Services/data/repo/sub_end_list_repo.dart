import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../model/endlist_model.dart';
import '../model/sublist_model.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

abstract class SubAndEndListRepo {
  static Future<ApiResult<EndServiceListModel>> endServiceList(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.user_end_service,
        method: ServerMethods.POST,
        body: formData,
        isUser: false,
      );
      return ApiResult.success(EndServiceListModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  static Future<ApiResult<SubServiceListModel>> subServiceList(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.user_sub_service,
        method: ServerMethods.POST,
        body: formData,
        isUser: false,
      );
      return ApiResult.success(SubServiceListModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
