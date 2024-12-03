import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class UserNotificationController {
  NetWork _util = NetWork();
  UserNotificationModel _model = UserNotificationModel();

  Future<UserNotificationModel> getNotification() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("user_token");

    Map<String, dynamic> header = {
      "Authorization": "Bearer $token",
    };

    var data = await _util.getData(url: "api/newindex", headers: header);
    print(data);
    if (data == null || data == "internet") {
      return _model;
    } else {
      _model = UserNotificationModel.fromJson(data);
      return _model;
    }
  }
}