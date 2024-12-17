import 'package:dio/dio.dart';

import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../../../../../../core/API/network_screvies.dart';
import '../model/ad_terms_model.dart';

abstract class AdFeaturesTermsRepo {
  static Future<ApiResult<AdFeaturesTermsModel>> getAdFeatures() async {
    try {
      final Response response = await NetworkHelper().request(
          "${ApiUtl.main_owner_api_url}probaganda",
          method: ServerMethods.GET);
      return ApiResult.success(AdFeaturesTermsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
