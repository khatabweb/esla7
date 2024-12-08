import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import '../../../../API/api_utility.dart';
import '../../../Widgets/helper/network_screvies.dart';
import 'model.dart';

abstract class AdsPackagesRepo {
  late AdsPackagesModel model;

  static Future<ApiResult<AdsPackagesModel>> getPackages() async {
    try {
      final Response data =
          await NetworkHelper().request("${ApiUtl.main_owner_api_url}packages");
      return ApiResult.success(AdsPackagesModel.fromJson(data.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
