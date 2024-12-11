import 'package:dio/dio.dart';
import '../../../../../API/api_error_handler.dart';
import '../../../../../API/api_result.dart';
import '../../../../../API/api_utility.dart';
import '../model/model.dart';
import '../../../../Widgets/helper/network_screvies.dart';

abstract class BankAccountRepo {
  static Future<ApiResult<BankAccountsModel>> createBankAccount() async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_owner_api_url}owner/banks",
        method: ServerMethods.GET,
      );
      return ApiResult.success(BankAccountsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
