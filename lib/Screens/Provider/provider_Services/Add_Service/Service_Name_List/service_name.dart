import 'data/bloc/state.dart';
import '../../../../Widgets/CenterMessage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../AddService/data/bloc/cubit.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_popover.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'data/bloc/cubit.dart';

class ServiceName extends StatefulWidget {
  const ServiceName({
    Key? key,
  }) : super(key: key);

  @override
  State<ServiceName> createState() => _ServiceNameState();
}

class _ServiceNameState extends State<ServiceName> {
  String? chooseValue;

  @override
  void initState() {
    context.read<ServiceNameCubit>().ownerServiceName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addCubit = AddServiceCubit.get(context);
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ServiceNameCubit, ServiceNameState>(
      builder: (context, state) {
        if (state is ServiceNameLoadingState) {
          return CenterLoading();
        } else if (state is ServiceNameErrorState) {
          return CenterMessage(state.error);
        } else if (state is ServiceNameSuccessState) {
          final _model = state.serviceNameModel;
          return CustomPopOver(
            width: width,
            dropWidth: width / 1.1,
            dropHeight: _model.endservices!.length == 0
                ? 45
                : _model.endservices!.length * 45,
            text: chooseValue ?? "service_name".tr(),
            color: Color(0xFFEEEEEE),
            itemList: _model.endservices!.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      print(item!.id);
                      context.locale.languageCode == "ar"
                          ? chooseValue = item.nameAr
                          : chooseValue = item.nameEn;
                      addCubit.serviceNameId = item.id;
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
          return CenterMessage("no data found");
        }
      },
    );
  }
}
