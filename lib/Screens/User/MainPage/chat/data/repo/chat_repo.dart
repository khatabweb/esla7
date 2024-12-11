import 'package:dio/dio.dart';
import '../../../../../../API/api_error_handler.dart';
import '../../../../../../API/api_result.dart';
import '../../../../../../API/api_utility.dart';
import '../model/model.dart';
import '../../../../../Widgets/helper/network_screvies.dart';

abstract class ChatRepo {
  static Future<ApiResult<ChatModel>> getMessage({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          '${ApiUtl.main_owner_api_url}api/getConversationById',
          method: ServerMethods.GET,
          body: formData);
      return ApiResult.success(ChatModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  static Future<ApiResult> sendMessage({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          '${ApiUtl.main_owner_api_url}api/addMassage',
          method: ServerMethods.POST,
          body: formData);
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  static Future<ApiResult> startChat({required FormData formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          '${ApiUtl.main_owner_api_url}api/addConversation',
          method: ServerMethods.POST,
          body: formData);
      return ApiResult.success(response.data['data']['conversation_id']);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
