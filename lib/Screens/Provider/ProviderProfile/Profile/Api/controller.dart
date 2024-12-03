import 'package:esla7/Screens/Provider/ProviderProfile/Profile/Api/model.dart';
import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerProfileController {
  NetWork _util = NetWork();
  OwnerProfileModel _profileModel = OwnerProfileModel();

  Future<OwnerProfileModel> getOwnerProfile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("owner_token");

    Map<String, dynamic> header = {
      "Authorization" : "Bearer $token",
    };

    var data = await _util.getData(url: "owner/ownerdetails", headers: header);
    print(data);

    if (data == null || data == "internet") {
      return _profileModel;
    } else {
      _profileModel = OwnerProfileModel.fromJson(data);
      return  _profileModel;
    }
  }
}