import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/data/model/ad_terms_model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

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
