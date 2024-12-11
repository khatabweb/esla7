import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../CommonScreen/Slider/presentation/slider_view.dart';
import '../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/Custom_AppBar.dart';
import '../../../../../Widgets/Custom_Background.dart';
import '../../../../../Widgets/Custom_DrawText.dart';
import '../../../../provider_Services/Services/presentation/screen/ServiceDetails_view.dart';
import '../../../ProviderDrawer/ProviderDrawer.dart';
import '../../data/cubit/owner_service_cubit.dart';

class ProviderHomePage extends StatefulWidget {
  @override
  State<ProviderHomePage> createState() => _ProviderHomePageState();
}

class _ProviderHomePageState extends State<ProviderHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String language = translator.activeLanguageCode;

  @override
  void initState() {
    context.read<OwnerServiceCubit>().getService();
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
                    child: DrawHeaderText(
                        text: "offers".tr(),
                        color: Theme.of(context).primaryColor),
                  ),
                  ImageSlider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: DrawHeaderText(
                        text: "my_services".tr(),
                        color: Theme.of(context).primaryColor),
                  ),
                  BlocBuilder<OwnerServiceCubit, OwnerServiceState>(
                    builder: (context, state) {
                      if (state is OwnerServiceLoading) {
                        return CenterLoading();
                      } else if (state is OwnerServiceError) {
                        return Center(child: Text("${state.error}"));
                      } else if (state is OwnerServiceSuccess) {
                        final _serviceModel = state.ownerServiceModel;
                        return _MyService(
                          text: language == "ar"
                              ? "${_serviceModel.ownerMainService?.nameAr}"
                              : "${_serviceModel.ownerMainService?.nameEn}",
                          image:
                              "${ApiUtl.main_image_url}${_serviceModel.ownerMainService?.image}",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ServiceDetails(
                                mainServiceId:
                                    _serviceModel.ownerMainService?.id,
                                mainServiceName: language == "ar"
                                    ? "${_serviceModel.ownerMainService?.nameAr}"
                                    : "${_serviceModel.ownerMainService?.nameEn}",
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(child: Text("No Data"));
                      }
                    },
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
            Expanded(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: image!,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: Center(child: DrawHeaderText(text: text ?? "")),
            )
          ],
        ),
      ),
    );
  }
}
