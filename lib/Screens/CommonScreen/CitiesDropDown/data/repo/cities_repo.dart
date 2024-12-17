import 'package:dio/dio.dart';
import '../../../../../core/API/network_screvies.dart';
import '../../../../../core/API/api_error_handler.dart';
import '../../../../../core/API/api_result.dart';
import '../../../../../core/API/api_utility.dart';
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
