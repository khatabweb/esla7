import 'package:esla7/Screens/CommonScreen/DrawerPages/models/aboutus_model.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/models/helping_model.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/models/terms_model.dart';
import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


///=========================== Terms and condition Request =============================
class TermsController {
  NetWork _util = NetWork();
  TermsModel _termsModel = TermsModel();

  Future<TermsModel> getTerms() async {
    var data = await _util.getData(url: "api/terms");
    print(data);
    if (data == null || data == "internet") {
      return _termsModel;
    } else {
      _termsModel = TermsModel.fromJson(data);
      return  _termsModel;
    }
  }
}


///=========================== About Us Request =============================
class AboutusController {
  NetWork _util = NetWork();
  AboutusModel _aboutusModel = AboutusModel();

  Future<AboutusModel> getAboutUs() async {
    var data = await _util.getData(url: "api/aboutus");
    print(data);
    if (data == null || data == "internet") {
      return _aboutusModel;
    } else {
      _aboutusModel = AboutusModel.fromJson(data);
      return  _aboutusModel;
    }
  }
}


///================================ Helping Request ==================================
class HelpingController {
  NetWork _util = NetWork();
  HelpingModel _helpingModel = HelpingModel();

  Future<HelpingModel> getHelp() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("user_token");

    Map<String, dynamic> header = {
      "Authorization" : "Bearer $token",
    };

    var data = await _util.getData(url: "api/helping", headers: header);
    print(data);

    if (data == null || data == "internet") {
      return _helpingModel;
    } else {
      _helpingModel = HelpingModel.fromJson(data);
      return  _helpingModel;
    }
  }
}