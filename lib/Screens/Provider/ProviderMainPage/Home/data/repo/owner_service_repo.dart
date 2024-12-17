import 'package:dio/dio.dart';
import '../../../../../../core/API/api_error_handler.dart';
import '../../../../../../core/API/api_result.dart';
import '../../../../../../core/API/api_utility.dart';
import '../model/model.dart';
import '../../../../../../core/API/network_screvies.dart';

abstract class OwnerServiceRepo {
  static Future<ApiResult<OwnerServiceModel>> getService() async {
    try {
      final Response response = await NetworkHelper().request(
        "${ApiUtl.main_owner_api_url}ownermainservice",
        method: ServerMethods.GET,
        isUser: false,
      );
      return ApiResult.success(OwnerServiceModel.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}

// import '../model/model.dart';

// import '../../../../../Widgets/helper/network_screvies.dart';

// class OwnerServiceController {
//   // NetWork _util = NetWork();
//   OwnerServiceModel _ownerServiceModel = OwnerServiceModel();

// //TODO: get service Base url
//   Future<OwnerServiceModel> getService() async {
//     var data = await NetworkHelper()
//         .request("owner/ownermainservice", method: ServerMethods.GET);
//     print(data);

//     if (data == null || data == "internet") {
//       return _ownerServiceModel;
//     } else {
//       _ownerServiceModel = OwnerServiceModel.fromJson(data);
//       return _ownerServiceModel;
//     }
//   }
// }
