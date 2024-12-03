import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/API/ad_terms_model.dart';
import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';

class AdFeaturesTermsController {
  NetWork _util = NetWork();
  AdFeaturesTermsModel _adFeaturesTermsModel = AdFeaturesTermsModel();

  Future<AdFeaturesTermsModel> getAdFeatures() async {
    var data = await _util.getData(url: "api/probaganda");
    print(data);

    if (data == null || data == "internet") {
      return _adFeaturesTermsModel;
    } else {
      _adFeaturesTermsModel = AdFeaturesTermsModel.fromJson(data);
      return  _adFeaturesTermsModel;
    }
  }
}