import '../../../../API/api_utility.dart';
import '../ProviderDrawer/ProviderDrawer.dart';
import '../../../CommonScreen/Slider/presentation/slider_view.dart';
import '../../provider_Services/Services/ServiceDetails_view.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_AppBar.dart';
import '../../../Widgets/Custom_Background.dart';
import '../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'main_service_api/controller.dart';
import 'main_service_api/model.dart';

class ProviderHomePage extends StatefulWidget {
  @override
  State<ProviderHomePage> createState() => _ProviderHomePageState();
}

class _ProviderHomePageState extends State<ProviderHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String language = translator.activeLanguageCode;

  OwnerServiceController _serviceController = OwnerServiceController();
  OwnerServiceModel _serviceModel = OwnerServiceModel();
  bool _isLoading = true;

  void getMainService() async {
    _serviceModel = await _serviceController.getService();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getMainService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: CustomBackground(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: customAppBar(
            context: context,
            showDrawerIcon: true,
            centerTitle: true,
            appBarTitle: "home".tr(),
            onPressedDrawer: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          drawer: ProviderDrawerView(),
          body: AnimatedWidgets(
            verticalOffset: 150,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: DrawHeaderText(text: "offers".tr(),color: Theme.of(context).primaryColor),
                  ),
                  ImageSlider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: DrawHeaderText(text: "my_services".tr(),color: Theme.of(context).primaryColor),
                  ),
                  _isLoading
                      ? CenterLoading()
                      : _MyService(
                          text: language == "ar"
                              ? "${_serviceModel.ownerMainService?.nameAr}"
                              : "${_serviceModel.ownerMainService?.nameEn}",
                          image: "${ApiUtl.main_image_url}${_serviceModel.ownerMainService?.image}",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ServiceDetails(
                                mainServiceId: _serviceModel.ownerMainService?.id,
                                mainServiceName: language == "ar"
                                    ? "${_serviceModel.ownerMainService?.nameAr}"
                                    : "${_serviceModel.ownerMainService?.nameEn}",
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _MyService extends StatelessWidget {
  final void Function()? onTap;
  final String? image;
  final String? text;
  _MyService({Key? key, this.onTap, this.image, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image!),
                  fit: BoxFit.contain,
                )
              ),
            ),),
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: Center(child: DrawHeaderText(text: text??"")),
            )
          ],
        ),
      ),
    );
  }
}


