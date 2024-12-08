// import 'model.dart';
// import '../../../../Widgets/helper/Network_Utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OwnerServiceController {
//   NetWork _util = NetWork();
//   OwnerDetailsModel _model = OwnerDetailsModel();
//   static int? ownerId;

//   Future<OwnerDetailsModel> getService() async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     final token = _pref.getString("owner_token");

//     Map<String, dynamic> header = {
//       "Authorization": "Bearer $token",
//     };

//     var data = await _util.getData(url: "owner/ownermainservice", headers: header);
//     print(data);

//     if (data == null || data == "internet") {
//       return _model;
//     } else {
//       _model = OwnerDetailsModel.fromJson(data);
//       return _model;
//     }
//   }
// }
