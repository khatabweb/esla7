import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

class UserFinishedController {
  NetWork _util = NetWork();
  OwnerFinishedModel _model = OwnerFinishedModel();

  Future<OwnerFinishedModel> getFinished() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("owner_token");

    Map<String, dynamic> header = {
      "Authorization": "Bearer $token",
    };

    var data = await _util.getData(url: "owner/finished-owner-orders", headers: header);
    print(data);

    if (data == null || data == "internet") {
      return _model;
    } else {
      _model = OwnerFinishedModel.fromJson(data);
      return _model;
    }
  }
}
