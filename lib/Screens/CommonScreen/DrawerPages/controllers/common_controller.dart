import 'package:dio/dio.dart';

import '../../../../API/api_utility.dart';
import '../../../Widgets/helper/network_screvies.dart';
import '../models/aboutus_model.dart';
import '../models/helping_model.dart';
import '../models/terms_model.dart';

//TODO: Add basUrl
///=========================== Terms and condition Request =============================
class TermsController {
  TermsModel _termsModel = TermsModel();

  Future<TermsModel> getTerms() async {
    final Response data = await NetworkHelper()
        .request("${ApiUtl.main_api_url}terms", method: ServerMethods.GET);

    print(data);
    if (data.statusCode == 200) {
      _termsModel = TermsModel.fromJson(data.data);
      return _termsModel;
    } else {
      return _termsModel;
    }
  }
}

///=========================== About Us Request =============================
class AboutusController {
  AboutusModel _aboutusModel = AboutusModel();

  Future<AboutusModel> getAboutUs() async {
    final Response data = await NetworkHelper()
        .request("${ApiUtl.main_api_url}aboutus", method: ServerMethods.GET);
    print(data);
    if (data.statusCode == 200) {
      _aboutusModel = AboutusModel.fromJson(data.data);
      return _aboutusModel;
    } else {
      return _aboutusModel;
    }
  }
}

///================================ Helping Request ==================================
class HelpingController {
  HelpingModel _helpingModel = HelpingModel();

  Future<HelpingModel> getHelp({bool isUser = true}) async {
    // var data = await _util.getData(url: "api/helping", headers: header);
    final Response data = await NetworkHelper().request(
        "${ApiUtl.main_api_url}helping",
        // "${ApiUtl.main_api_url}http://repaairsa.com/api/helping",
        method: ServerMethods.GET,
        isUser: isUser);
    print(data);

    if (data.statusCode == 200) {
      _helpingModel = HelpingModel.fromJson(data.data);
      return _helpingModel;
    } else {
      return _helpingModel;
    }
  }
}
