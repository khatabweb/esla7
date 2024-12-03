import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'advertisers_model.dart';

class AdvertisersController {
  NetWork _util = NetWork();
  AdvertisersModel _advertisersModel = AdvertisersModel();

  Future<AdvertisersModel> getAdvertisers() async {
    var data = await _util.getData(url: "api/advertisers");
    print(data);
    if (data == null || data == "internet") {
      return _advertisersModel;
    } else {
      _advertisersModel = AdvertisersModel.fromJson(data);
      return  _advertisersModel;
    }
  }
}