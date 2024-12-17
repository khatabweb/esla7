import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../../Widgets/CenterLoading.dart';
import '../../../../../../Widgets/Custom_DrawText.dart';
import '../../../../../../Widgets/Custom_popover.dart';
import '../../../data/bloc/cubit.dart';
import 'data/cubit/service_type_cubit.dart';

class ServiceType extends StatefulWidget {
  @override
  State<ServiceType> createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {
  String? value;

  @override
  void initState() {
    context.read<ServiceTypeCubit>().getServiceType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ServiceTypeCubit, ServiceTypeState>(
        builder: (context, state) {
      if (state is ServiceTypeLoading) {
        return CenterLoading();
      } else if (state is ServiceTypeError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is ServiceTypeSuccess) {
        final _model = state.model;
        return CustomPopOver(
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
                    context.locale.languageCode == "ar"
                        ? value = "${item?.nameAr}"
                        : value = "${item?.nameEn}";
                    cubit.serviceId = item?.id;
                    print(
                        "owner register service id ::::::::: ${cubit.serviceId}");
                  });
                },
                child: DrawHeaderText(
                  textAlign: TextAlign.center,
                  text: context.locale.languageCode == "ar"
                      ? "${item?.nameAr}"
                      : "${item?.nameEn}",
                ),
              ),
            );
          }).toList(),
        );
      } else {
        return Center(
          child: Text("no data found "),
        );
      }
    });
  }
}
