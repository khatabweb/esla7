import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'model.dart';

class ServiceTypeController {
  NetWork _util = NetWork();
  ServiceTypeModel _model = ServiceTypeModel();

  Future<ServiceTypeModel> getServices() async {
    var data = await _util.getData(url: "api/mainservices");
    print(data);
    if (data == null || data == "internet") {
      return _model;
    } else {
      _model = ServiceTypeModel.fromJson(data);
      return  _model;
    }
  }
}