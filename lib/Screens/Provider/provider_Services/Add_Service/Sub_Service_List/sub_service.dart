import '../AddService/bloc/cubit.dart';
import '../Service_Name_List/bloc/cubit.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_popover.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bloc/cubit.dart';

class SubServiceType extends StatefulWidget {
  final int? mainServiceId;
  const SubServiceType({Key? key, this.mainServiceId}) : super(key: key);

  @override
  State<SubServiceType> createState() => _SubServiceTypeState();
}

class _SubServiceTypeState extends State<SubServiceType> {
  final String language = translator.activeLanguageCode;
  bool isLoading = true;
  String? chooseValue;

  Future ownerSubService() {
    final cubit = SubServiceCubit.get(context);
    cubit.serviceId = widget.mainServiceId;
    print("service idddddddddddddd :::: ${cubit.serviceId}");
    print("service List :::: ${cubit.subServiceModel.subservices}");
    return cubit.ownerSubService();
  }


  @override
  void initState() {
    ownerSubService().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final cubit = SubServiceCubit.get(context);
    final endServiceCubit = ServiceNameCubit.get(context);
    final addCubit = AddServiceCubit.get(context);
    return isLoading
        ? CenterLoading()
        : CustomPopOver(
            width: width,
            dropWidth: width / 1.1,
            text: chooseValue ?? "sub_service".tr(),
            color: Color(0xFFEEEEEE),
            dropHeight: cubit.subServiceModel.subservices!.length == 0
                ? 45
                : cubit.subServiceModel.subservices!.length.toDouble() * 45,
            itemList: cubit.subServiceModel.subservices!.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      print(item!.id);
                      language == "ar"
                          ? chooseValue = item.nameAr
                          : chooseValue = item.nameEn;
                      addCubit.subServiceId = item.id;
                      endServiceCubit.serviceId = item.id;
                      endServiceCubit.ownerServiceName();
                    });
                  },
                  child: DrawHeaderText(
                    textAlign: TextAlign.center,
                    text: language == "ar"
                        ? "${item?.nameAr}"
                        : "${item?.nameEn}",
                  ),
                ),
              );
            }).toList(),
          );
  }
}