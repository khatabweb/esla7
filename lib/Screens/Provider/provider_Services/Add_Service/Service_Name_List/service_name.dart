import 'package:esla7/Screens/Provider/provider_Services/Add_Service/AddService/bloc/cubit.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_popover.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bloc/cubit.dart';

class ServiceName extends StatefulWidget {
  const ServiceName({Key? key,}) : super(key: key);

  @override
  State<ServiceName> createState() => _ServiceNameState();
}

class _ServiceNameState extends State<ServiceName> {
  final String language = translator.activeLanguageCode;
  bool isLoading = true;
  String? chooseValue;

  Future ownerServiceName() {
    final cubit = ServiceNameCubit.get(context);
    /// cubit.serviceId added from sub service view
    print("service idddddddddddddd :::: ${cubit.serviceId}");
    print("service List :::: ${cubit.serviceNameModel.endservices}");
    return cubit.ownerServiceName();
  }


  @override
  void initState() {
    ownerServiceName().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ServiceNameCubit.get(context);
    final addCubit = AddServiceCubit.get(context);
    double width = MediaQuery.of(context).size.width;
    return isLoading
        ? CenterLoading()
        : CustomPopOver(
            width: width,
            dropWidth: width / 1.1,
            dropHeight: cubit.serviceNameModel.endservices!.length == 0
                ? 45
                : cubit.serviceNameModel.endservices!.length * 45,
            text: chooseValue ?? "service_name".tr(),
            color: Color(0xFFEEEEEE),
            itemList: cubit.serviceNameModel.endservices!.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      print(item!.id);
                      language == "ar"
                          ? chooseValue = item.nameAr
                          : chooseValue = item.nameEn;
                      addCubit.serviceNameId = item.id;
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