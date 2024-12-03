import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../API/api_utility.dart';
import 'API/slider_controller.dart';
import 'API/slider_models.dart';
import '../../Widgets/CenterLoading.dart';
import '../../Widgets/CenterMessage.dart';
import '../../Widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ImageSlider extends StatefulWidget {
  final AssetImage? sliderImgSrc;

  ImageSlider({this.sliderImgSrc});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int current = 0;
  SliderController _sliderController = SliderController();
  SliderModel _sliderModel = SliderModel();
  bool _isLoading = true;

  void _getSliders() async {
    _sliderModel = await _sliderController.getBanners();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return _isLoading
        ? CenterLoading()
        : _sliderModel.banners?.length == 0
            ? _NoOrdersContainer()
            : CarouselSlider(
                items: _sliderModel.banners!.map(
                  (item) {
                    return Container(
                      width: width,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // image:
                        // DecorationImage(
                        //   image: NetworkImage("${ApiUtl.main_image_url}${item!.image}"),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: "${ApiUtl.main_image_url}${item!.image}",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height / 4,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        current = index;
                      },
                    );
                  },
                ),
              );
  }
}

class _NoOrdersContainer extends StatelessWidget {
  const _NoOrdersContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 4,
      width: width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage("assets/images/a5.jpg"),
            fit: BoxFit.cover,
          )),
      child: Container(
        height: height / 4,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(1),
              Theme.of(context).primaryColor.withOpacity(1),
              Theme.of(context).primaryColor.withOpacity(0.9),
              Theme.of(context).primaryColor.withOpacity(0.9),
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.7),
              Theme.of(context).primaryColor.withOpacity(0.5),
              Theme.of(context).primaryColor.withOpacity(0.5),
              Theme.of(context).primaryColor.withOpacity(0.3),
              Theme.of(context).primaryColor.withOpacity(0.2),
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).primaryColor.withOpacity(0.05),
              Theme.of(context).primaryColor.withOpacity(0.025),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(verticalOffset: 0, size: 100),
            SizedBox(height: 10),
            CenterMessage("there_are_no_ads_banners_now".tr(),
                textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
