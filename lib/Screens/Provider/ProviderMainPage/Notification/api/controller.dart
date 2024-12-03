import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class OwnerNotificationController {
  NetWork _util = NetWork();
  OwnerNotificationModel _model = OwnerNotificationModel();

  Future<OwnerNotificationModel> getNotification() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("owner_token");

    Map<String, dynamic> header = {
      "Authorization": "Bearer $token",
    };

    var data = await _util.getData(url: "owner/newownerindex", headers: header);
    print(data);
    if (data == null || data == "internet") {
      return _model;
    } else {
      _model = OwnerNotificationModel.fromJson(data);
      return _model;
    }
  }
}