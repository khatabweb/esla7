import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/SingleSection/View.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_Section.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'Api/controller.dart';
import 'Api/model.dart';

class OurServices extends StatefulWidget {
  @override
  State<OurServices> createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  final String lang = translator.activeLanguageCode;
  MainServicesController _servicesController = MainServicesController();
  MainServicesModel _servicesModel = MainServicesModel();
  bool _isLoading = true;

  void getData() async {
    _servicesModel = await _servicesController.getServices();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return _isLoading ? CenterLoading() : Container(
      height: screenHeight / 2.8,
      padding: EdgeInsets.only(bottom: 10),
      width: screenWidth,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _servicesModel.services!.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomSection(
                    title: lang == "ar"
                        ? "${_servicesModel.services![index]!.nameAr}"
                        : "${_servicesModel.services![index]!.nameEn}",
                    image: "${ApiUtl.main_image_url}${_servicesModel.services![index]!.image}",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SingleSection(
                          serviceName: lang == "ar"
                              ? "${_servicesModel.services![index]!.nameAr}"
                              : "${_servicesModel.services![index]!.nameEn}",
                          mainServiceId: _servicesModel.services![index]!.id,
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}