import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';
import 'owners_model.dart';

class OwnersController {
  OwnersModel _ownersModel = OwnersModel();

  Future<OwnersModel> getOwners() async {
    var data = await NetworkHelper()
        .request("${ApiUtl.main_api_url}api/owners", method: ServerMethods.GET);
    print(data);
    if (data == null || data == "internet") {
      return _ownersModel;
    } else {
      _ownersModel = OwnersModel.fromJson(data);
      return _ownersModel;
    }
  }
}
