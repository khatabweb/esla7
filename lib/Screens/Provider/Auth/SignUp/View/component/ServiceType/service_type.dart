import 'package:esla7/Screens/Provider/Auth/SignUp/bloc/cubit.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_popover.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'api/controller.dart';
import 'api/model.dart';

class ServiceType extends StatefulWidget {
  @override
  State<ServiceType> createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {
  final String lang = translator.activeLanguageCode;
  ServiceTypeController _controller = ServiceTypeController();
  ServiceTypeModel _model = ServiceTypeModel();
  bool isLoading = true;
  String? value;

  void getService() async {
    _model = await _controller.getServices();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    double width = MediaQuery.of(context).size.width;
    return isLoading
        ? CenterLoading()
        : CustomPopOver(
            width: width,
            dropWidth: width / 1.1,
            dropHeight: _model.services!.length.toDouble() * 50,
            text: value ?? "service_type".tr(),
            color: Color(0xFFEEEEEE),
            itemList: _model.services!.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      lang == "ar"
                          ? value = "${item?.nameAr}"
                          : value = "${item?.nameEn}";
                      cubit.serviceId = item?.id;
                      print("owner register service id ::::::::: ${cubit.serviceId}");
                    });
                  },
                  child: DrawHeaderText(
                    textAlign: TextAlign.center,
                    text: lang == "ar" ? "${item?.nameAr}" : "${item?.nameEn}",
                  ),
                ),
              );
            }).toList(),
          );
  }
}