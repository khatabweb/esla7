import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

class UserFinishedController {
  NetWork _util = NetWork();
  UserFinishedModel _model = UserFinishedModel();

  Future<UserFinishedModel> getFinished() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("user_token");

    Map<String, dynamic> header = {
      "Authorization": "Bearer $token",
    };

    var data = await _util.getData(url: "api/finished_orders", headers: header);
    print(data);

    if (data == null || data == "internet") {
      return _model;
    } else {
      _model = UserFinishedModel.fromJson(data);
      return _model;
    }
  }
}
