import '../models/aboutus_model.dart';
import '../models/helping_model.dart';
import '../models/terms_model.dart';
import '../../../Widgets/helper/network_screvies.dart';


//TODO: Add basUrl 
///=========================== Terms and condition Request =============================
class TermsController {
  TermsModel _termsModel = TermsModel();

  Future<TermsModel> getTerms() async {
    var data =
        await NetworkHelper().request("api/terms", method: ServerMethods.GET);
    ;
    print(data);
    if (data == null || data == "internet") {
      return _termsModel;
    } else {
      _termsModel = TermsModel.fromJson(data);
      return _termsModel;
    }
  }
}

///=========================== About Us Request =============================
class AboutusController {
  AboutusModel _aboutusModel = AboutusModel();

  Future<AboutusModel> getAboutUs() async {
    var data =
        await NetworkHelper().request("api/aboutus", method: ServerMethods.GET);
    print(data);
    if (data == null || data == "internet") {
      return _aboutusModel;
    } else {
      _aboutusModel = AboutusModel.fromJson(data);
      return _aboutusModel;
    }
  }
}

///================================ Helping Request ==================================
class HelpingController {
  HelpingModel _helpingModel = HelpingModel();

  Future<HelpingModel> getHelp() async {
    // var data = await _util.getData(url: "api/helping", headers: header);
    var data =
        await NetworkHelper().request("api/helping", method: ServerMethods.GET);
    print(data);

    if (data == null || data == "internet") {
      return _helpingModel;
    } else {
      _helpingModel = HelpingModel.fromJson(data);
      return _helpingModel;
    }
  }
}
