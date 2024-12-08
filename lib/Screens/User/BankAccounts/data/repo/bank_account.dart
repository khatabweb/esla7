import 'package:dio/dio.dart';
import 'package:esla7/API/api_error_handler.dart';
import 'package:esla7/API/api_result.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/BankAccounts/data/model/model.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

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
