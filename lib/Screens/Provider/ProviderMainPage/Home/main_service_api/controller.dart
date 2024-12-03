import 'package:esla7/Screens/Provider/ProviderMainPage/Home/main_service_api/model.dart';

import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';

class OwnerServiceController {
  // NetWork _util = NetWork();
  OwnerServiceModel _ownerServiceModel = OwnerServiceModel();


//TODO: get service Base url 
  Future<OwnerServiceModel> getService() async {
    var data = await NetworkHelper()
        .request("owner/ownermainservice", method: ServerMethods.GET);
    print(data);

    if (data == null || data == "internet") {
      return _ownerServiceModel;
    } else {
      _ownerServiceModel = OwnerServiceModel.fromJson(data);
      return _ownerServiceModel;
    }
  }
}
