import 'package:dio/dio.dart';
import '../../../../../core/API/api_error_handler.dart';
import '../../../../../core/API/api_result.dart';
import '../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../core/API/network_screvies.dart';

abstract class BankAccountRepo {
  static Future<ApiResult<BankAccountsModel>> createBankAccount(
      {required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_api_url}bankDetails",
        method: ServerMethods.POST,
        body: formData,
      );
      return ApiResult.success(BankAccountsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
