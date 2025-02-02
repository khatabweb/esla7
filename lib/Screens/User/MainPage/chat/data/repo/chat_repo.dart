import 'package:dio/dio.dart';
import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../core/API/network_screvies.dart';

abstract class ChatRepo {
  static Future<ApiResult<ChatModel>> getMessage({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          '${ApiUtl.main_api_url}getConversationById',
          method: ServerMethods.POST,
          body: formData);
      return ApiResult.success(ChatModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  static Future<ApiResult> sendMessage({required formData}) async {
    try {
      final Response response = await NetworkHelper().request(
          '${ApiUtl.main_api_url}addMassage',
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
          '${ApiUtl.main_api_url}addConversation',
          method: ServerMethods.POST,
          body: formData);
      return ApiResult.success(response.data['data'][0]['conversation_id']);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
