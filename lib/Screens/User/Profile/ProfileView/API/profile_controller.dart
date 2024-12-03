import 'package:esla7/Screens/User/Profile/ProfileView/API/profile_model.dart';
import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  NetWork _util = NetWork();
  ProfileModel _profileModel = ProfileModel();

  Future<ProfileModel> getUserProfile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("user_token");

    Map<String, dynamic> header = {
      "Authorization" : "Bearer $token",
    };

    var data = await _util.getData(url: "api/user", headers: header);
    print(data);

    if (data == null || data == "internet") {
      return _profileModel;
    } else {
      _profileModel = ProfileModel.fromJson(data);
      return  _profileModel;
    }
  }
}