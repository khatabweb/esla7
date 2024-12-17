import 'package:dio/dio.dart';
import '../../../../../../core/API/api_utility.dart';
import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../model/AllChatsModel.dart';
import '../../../../../../core/API/network_screvies.dart';

class AllChatsRepo {
  Future<ApiResult<AllChatsModel>> getAllChats(
      {required FormData formData, bool isUser = true}) async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_api_url}getConversationByUser_id",
        method: ServerMethods.POST,
        body: formData,
        isUser: isUser,
      );
      return ApiResult.success(AllChatsModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  // Future<AllChatsModel> getAllChats() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   var id;
  //   if(_prefs.getString("type") == 'user'){
  //     id = _prefs.getInt("user_id");
  //     print('user id : $id');
  //   }else{
  //     id = _prefs.getInt("owner_id");
  //     print('owner id : $id');
  //   }
  //   print("my id get storage : ${box.read('id')}");
  //   final token = _prefs.getString("user_token");
  //   Map<String, dynamic> _body = {
  //     "user_id": id,
  //   };

  //   FormData _formData = FormData.fromMap(_body);

  //   // dio.options.headers = {
  //   //   "Content-Type":"application/json",
  //   //   "X-Requested-With":"XMLHttpRequest",
  //   //   "Authorization" : "Bearer $token",
  //   // };
  //   final Response response = await dio.post("http://repaairsa.com/api/getConversationByUser_id", data: _formData);
  //   print("a7aaaaaaaaaaa${response.data}");
  //   if (response.data !=null) {
  //     _allChatsModel = AllChatsModel.fromJson(response.data);
  //   } else {
  //     _allChatsModel = AllChatsModel();
  //   }
  //   return _allChatsModel;
  // }
}
