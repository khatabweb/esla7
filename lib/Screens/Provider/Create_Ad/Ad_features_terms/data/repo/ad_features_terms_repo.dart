import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../model/ad_terms_model.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

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
