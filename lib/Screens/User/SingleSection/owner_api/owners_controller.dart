import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';
import 'owners_model.dart';

class OwnersController {
  NetWork _util = NetWork();
  OwnersModel _ownersModel = OwnersModel();

  Future<OwnersModel> getOwners() async {
    var data = await _util.getData(url: "api/owners");
    print(data);
    if (data == null || data == "internet") {
      return _ownersModel;
    } else {
      _ownersModel = OwnersModel.fromJson(data);
      return  _ownersModel;
    }
  }
}