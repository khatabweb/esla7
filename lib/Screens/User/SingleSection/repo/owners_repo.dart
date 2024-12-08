import 'package:dio/dio.dart';
import '../../../../API/api_error_handler.dart';
import '../../../../API/api_result.dart';
import '../../../../API/api_utility.dart';
import '../owner_bloc/model.dart';
import '../../../Widgets/helper/network_screvies.dart';

abstract class OwnersRepo {
  static Future<ApiResult<OwnerModel>> getOwners({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        ApiUtl.owners_list,
        body: formData,
        method: ServerMethods.POST,
      );
      return ApiResult.success(OwnerModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
