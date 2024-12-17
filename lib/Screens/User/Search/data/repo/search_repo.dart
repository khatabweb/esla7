import 'package:dio/dio.dart';
import '../../../../../core/API/api_error_handler.dart';
import '../../../../../core/API/api_result.dart';
import '../../../../../core/API/api_utility.dart';
import '../../../../../core/API/network_screvies.dart';
import '../model/model.dart';

abstract class SearchRepo {
  static Future<ApiResult<SearchModel>> search({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          ApiUtl.user_search,
          body: formData,
          method: ServerMethods.POST);

      if (response.data["message"] == "success") {
        return ApiResult.success(SearchModel.fromJson(response.data));
      } else {
        return ApiResult.failure(ErrorHandler.handle(response.data));
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
