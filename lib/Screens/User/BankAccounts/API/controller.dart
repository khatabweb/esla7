// import '../data/model/model.dart';

// class BankAccountsController {
//   // NetWork _util = NetWork();
//   BankAccountsModel _model = BankAccountsModel();

//   Future<BankAccountsModel> getBanks() async {
//     var data = await _util.getData(url: "owner/banks");
//     print(data);
//     if (data == null || data == "internet") {
//       return _model;
//     } else {
//       _model = BankAccountsModel.fromJson(data);
//       return  _model;
//     }
//   }
// }