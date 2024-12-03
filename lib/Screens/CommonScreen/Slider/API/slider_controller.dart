import 'package:esla7/Screens/CommonScreen/Slider/API/slider_models.dart';
import 'package:esla7/Screens/Widgets/helper/Network_Utils.dart';


class SliderController {
  NetWork _util = NetWork();
  SliderModel _sliderModel = SliderModel();

  Future<SliderModel> getBanners() async {
    var data = await _util.getData(url: "api/banners");
    print(data);

    if (data == null || data == "internet") {
      return _sliderModel;
    } else {
      _sliderModel = SliderModel.fromJson(data);
      return  _sliderModel;
    }
  }
}