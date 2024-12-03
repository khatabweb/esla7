import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/ProviderProfile/OwnerDetails/ProviderProfile.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'advertiser_api/advertisers_controller.dart';
import 'advertiser_api/advertisers_model.dart';
import 'owner_api/owners_controller.dart';
import 'owner_api/owners_model.dart';
import 'owner_bloc/cubit.dart';
import 'widgets/SingleProviderCard.dart';

class SingleSection extends StatefulWidget {
  final String? serviceName;
  final int? mainServiceId;
  const SingleSection({Key? key, this.mainServiceId, this.serviceName}) : super(key: key);

  @override
  State<SingleSection> createState() => _SingleSectionState();
}

class _SingleSectionState extends State<SingleSection> {
  final String lang = translator.activeLanguageCode;
  bool _isLoading = true;
  bool loading = true;

  ///Advertisers Api
  AdvertisersController _advertisersController = AdvertisersController();
  AdvertisersModel _advertisersModel = AdvertisersModel();

  ///Owners Api
  // OwnersController _ownersController = OwnersController();
  // OwnersModel _ownersModel = OwnersModel();

  void getData() async{
    _advertisersModel = await _advertisersController.getAdvertisers();
    // _ownersModel = await _ownersController.getOwners();
    setState(() {
      _isLoading = false;
    });
  }

  Future getOwners(){
    final ownersCubit = OwnersCubit.get(context);
    return ownersCubit.getOwners(widget.mainServiceId);
  }

  @override
  void initState() {
    getData();
    getOwners().then((value) => setState(() => loading = false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ownersCubit = OwnersCubit.get(context);
    final double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "${widget.serviceName}",
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        body: CustomBackground(
          child: (_isLoading || loading)
              ? CenterLoading()
              : (ownersCubit.ownersModel.owners!.length == 0 && _advertisersModel.advertisers!.length == 0)
                  ? CenterMessage("there_are_no_providers".tr())
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: AnimatedWidgets(
                        verticalOffset: 50,
                        child: Column(
                          children: [

                            ///::::::::::::: Advertiser List ::::::::::::::::
                            Container(
                              height: height * 0.15 * _advertisersModel.advertisers!.length.toDouble() + (_advertisersModel.advertisers!.length.toDouble() * 10),
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: _advertisersModel.advertisers!.length,
                                itemBuilder: (context, index) {
                                  var item = _advertisersModel.advertisers![index];
                                  return SingleProviderCard(
                                    isGolden: true,
                                    name: item!.ownerName,
                                    city: lang == "ar"
                                        ? item.city!.nameAr
                                        : item.city!.nameEn,
                                    rate: item.rate ?? 0,
                                    serviceName: lang == "ar"
                                        ? item.service!.nameAr
                                        : item.service!.nameEn,
                                    image: "${ApiUtl.main_image_url}${item.ownerImage}",
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProviderProfile(
                                          mainServiceId: widget.mainServiceId,
                                          isGolden: true,
                                          ownerId: item.id,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),


                            ///::::::::::::: Owners List ::::::::::::::::
                            Container(
                              height: height * 0.15 * ownersCubit.ownersModel.owners!.length.toDouble() + (ownersCubit.ownersModel.owners!.length.toDouble() * 10),
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: ownersCubit.ownersModel.owners!.length,
                                itemBuilder: (context, index) {
                                  var item = ownersCubit.ownersModel.owners![index];
                                  return SingleProviderCard(
                                    isGolden: false,
                                    name: item!.ownerName,
                                    image: "${ApiUtl.main_image_url}${item.ownerImage}",
                                    serviceName: lang == "ar"
                                        ? "${item.service?.nameAr}"
                                        : "${item.service?.nameEn}",
                                    rate: item.rate ?? 0,
                                    city: lang == "ar"
                                        ? "${item.city?.nameAr}"
                                        : "${item.city?.nameEn}",
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProviderProfile(
                                          mainServiceId: widget.mainServiceId,
                                          isGolden: false,
                                          ownerId: item.id,
                                        ),
                                      ),
                                    ),
                                  );
                                },
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