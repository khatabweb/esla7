// import '../data/model/cities_model.dart';
// import '../../../Widgets/helper/Network_Utils.dart';

// class CitiesController {
//   NetWork _util = NetWork();
//   CitiesModel _citiesModel = CitiesModel();

//   Future<CitiesModel> getCity() async {
//     var data = await _util.getData(url: "api/cities");
//     print(data);

//     if (data == null || data == "internet") {
//       return _citiesModel;
//     } else {
//       _citiesModel = CitiesModel.fromJson(data);
//       return  _citiesModel;
//     }

//   }
// }