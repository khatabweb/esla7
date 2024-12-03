import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';

import 'model.dart';

class AdsPackagesController {
  NetWork _util = NetWork();
  AdsPackagesModel model = AdsPackagesModel();

  Future<AdsPackagesModel> getPackages() async {
    var data = await _util.getData(url: "owner/packages");
    print(data);
    if (data == null || data == "internet") {
      return model;
    } else {
      model = AdsPackagesModel.fromJson(data);
      return  model;
    }
  }
}