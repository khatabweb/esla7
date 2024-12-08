// import '../../../../../Widgets/helper/Network_Utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../data/model/model.dart';

// class UserCurrentController {
//   // NetWork _util = NetWork();
//   OwnerCurrentModel _model = OwnerCurrentModel();

//   Future<OwnerCurrentModel> getCurrent() async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     final token = _pref.getString("owner_token");

//     Map<String, dynamic> header = {
//       "Authorization": "Bearer $token",
//     };

//     var data = await _util.getData(url: "owner/current-owner-orders", headers: header);
//     print(data);

//     if (data == null || data == "internet") {
//       return _model;
//     } else {
//       _model = OwnerCurrentModel.fromJson(data);
//       return _model;
//     }
//   }
// }
