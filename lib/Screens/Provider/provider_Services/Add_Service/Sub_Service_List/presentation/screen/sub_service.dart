import '../../data/bloc/state.dart';
import '../../../../../../Widgets/CenterMessage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../AddService/data/bloc/cubit.dart';
import '../../../Service_Name_List/data/bloc/cubit.dart';
import '../../../../../../Widgets/CenterLoading.dart';
import '../../../../../../Widgets/Custom_DrawText.dart';
import '../../../../../../Widgets/Custom_popover.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../data/bloc/cubit.dart';

class SubServiceType extends StatefulWidget {
  final int? mainServiceId;
  const SubServiceType({Key? key, this.mainServiceId}) : super(key: key);

  @override
  State<SubServiceType> createState() => _SubServiceTypeState();
}

class _SubServiceTypeState extends State<SubServiceType> {
  String? chooseValue;

  @override
  void initState() {
    context.read<SubServiceCubit>().ownerSubService(widget.mainServiceId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<SubServiceCubit, SubServiceState>(
      builder: (context, state) {
        if (state is SubServiceLoadingState) {
          return CenterLoading();
        } else if (state is SubServiceErrorState) {
          return CenterMessage(state.error);
        } else if (state is SubServiceSuccessState) {
          final cubit = state.subServiceModel;
          final endServiceCubit = ServiceNameCubit.get(context);
          final addCubit = AddServiceCubit.get(context);
          return CustomPopOver(
            width: width,
            dropWidth: width / 1.1,
            text: chooseValue ?? "sub_service".tr(),
            color: Color(0xFFEEEEEE),
            dropHeight: cubit.subservices!.length == 0
                ? 45
                : cubit.subservices!.length.toDouble() * 45,
            itemList: cubit.subservices!.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      print(item!.id);
                      context.locale.languageCode == "ar"
                          ? chooseValue = item.nameAr
                          : chooseValue = item.nameEn;
                      addCubit.subServiceId = item.id;
                      endServiceCubit.serviceId = item.id;
                      endServiceCubit.ownerServiceName();
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
          return CenterMessage("no data found ");
        }
      },
    );
  }
}
