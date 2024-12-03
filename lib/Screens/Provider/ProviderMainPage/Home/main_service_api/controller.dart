import 'package:esla7/Screens/Provider/ProviderMainPage/Home/main_service_api/model.dart';
import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerServiceController {
  NetWork _util = NetWork();
  OwnerServiceModel _ownerServiceModel = OwnerServiceModel();

  Future<OwnerServiceModel> getService() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("owner_token");

    Map<String, dynamic> header = {
      "Authorization": "Bearer $token",
    };

    var data = await _util.getData(url: "owner/ownermainservice", headers: header);
    print(data);

    if (data == null || data == "internet") {
      return _ownerServiceModel;
    } else {
      _ownerServiceModel = OwnerServiceModel.fromJson(data);
      return _ownerServiceModel;
    }
  }
}
