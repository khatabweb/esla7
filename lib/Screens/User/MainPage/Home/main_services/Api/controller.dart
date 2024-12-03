import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'model.dart';

class MainServicesController {
  NetWork _util = NetWork();
  MainServicesModel _mainServicesModel = MainServicesModel();

  Future<MainServicesModel> getServices() async {
    var data = await _util.getData(url: "api/mainservices");
    print(data);
    if (data == null || data == "internet") {
      return _mainServicesModel;
    } else {
      _mainServicesModel = MainServicesModel.fromJson(data);
      return  _mainServicesModel;
    }
  }
}