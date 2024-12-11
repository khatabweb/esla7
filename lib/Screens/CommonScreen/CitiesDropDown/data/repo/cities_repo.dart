import 'package:dio/dio.dart';
import '../../../../../API/api_error_handler.dart';
import '../../../../../API/api_result.dart';
import '../../../../../API/api_utility.dart';
import '../../../../Widgets/helper/network_screvies.dart';
import '../model/cities_model.dart';

abstract class CitiesRepo {
  static Future<ApiResult<CitiesModel>> getCities() async {
    try {
      final Response response = await NetworkHelper()
          .request("${ApiUtl.main_api_url}cities", method: ServerMethods.GET);

      return ApiResult.success(CitiesModel.fromJson(response.data));
    } catch (error) {
      print("::::::::::: Cities catch error ::::::::::::::");
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
