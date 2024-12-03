import 'package:dio/dio.dart';
import 'package:esla7/Screens/User/MainPage/allChats/model/AllChatsModel.dart';
import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllChatsController {
  AllChatsModel _allChatsModel =AllChatsModel();
  NetWork _netWork = NetWork();
  Dio dio = Dio();
  GetStorage box =GetStorage();
  Future<AllChatsModel> getAllChats() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id;
    if(_prefs.getString("type") == 'user'){
      id = _prefs.getInt("user_id");
      print('user id : $id');
    }else{
      id = _prefs.getInt("owner_id");
      print('owner id : $id');
    }
    print("my id get storage : ${box.read('id')}");
    final token = _prefs.getString("user_token");
    Map<String, dynamic> _body = {
      "user_id": id,
    };

    FormData _formData = FormData.fromMap(_body);

    // dio.options.headers = {
    //   "Content-Type":"application/json",
    //   "X-Requested-With":"XMLHttpRequest",
    //   "Authorization" : "Bearer $token",
    // };
    final Response response = await dio.post("http://repaairsa.com/api/getConversationByUser_id", data: _formData);
    print("a7aaaaaaaaaaa${response.data}");
    if (response.data !=null) {
      _allChatsModel = AllChatsModel.fromJson(response.data);
    } else {
      _allChatsModel = AllChatsModel();
    }
    return _allChatsModel;
  }
}