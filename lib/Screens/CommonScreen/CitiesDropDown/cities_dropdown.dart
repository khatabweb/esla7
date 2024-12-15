import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../Provider/Auth/SignUp/data/bloc/cubit.dart';
import '../../Widgets/CenterLoading.dart';
import '../../Widgets/Custom_DrawText.dart';
import '../../Widgets/Custom_popover.dart';
import 'data/cubit/cities_dropdown_cubit.dart';

// ignore: must_be_immutable
class CitiesDropdown extends StatefulWidget {
  late int? cityId;
  final Color? color;
  final bool? ownerRegister;
  final double? horizontalPadding;
  CitiesDropdown({
    Key? key,
    this.cityId,
    this.color,
    this.horizontalPadding,
    this.ownerRegister,
  }) : super(key: key);

  @override
  State<CitiesDropdown> createState() => _CitiesDropdownState();
}

class _CitiesDropdownState extends State<CitiesDropdown> {

  String? chooseValue;

  @override
  void initState() {
    context.read<CitiesDropdownCubit>().getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registerCubit = OwnerSignUpCubit.get(context);
    return BlocBuilder<CitiesDropdownCubit, CitiesDropdownState>(
      builder: (context, state) {
        if (state is CitiesDropdownLoading) {
          return CenterLoading();
        } else if (state is CitiesDropdownSuccess) {
          final _citiesModel = state.citiesModel;
          return CustomPopOver(
            horizontalPadding: widget.horizontalPadding ?? 15,
            width: MediaQuery.of(context).size.width,
            text: chooseValue == null ? "city".tr() : chooseValue,
            color: widget.color ?? Colors.white,
            dropWidth: MediaQuery.of(context).size.width / 1.1,
            dropHeight: _citiesModel.cities!.length.toDouble() * 45,
            itemList: _citiesModel.cities!.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    print(item.id);
                    context.locale.languageCode == "ar"
                        ? chooseValue = item.nameAr
                        : chooseValue = item.nameEn;
                    widget.ownerRegister == true
                        ? registerCubit.cityId = item.id
                        : widget.cityId = item.id;
                    setState(() {});
                    print("city ID :::::::::::::::::: ${item.id}");
                    print(
                        "owner register city id :::::::::::::::::: ${registerCubit.cityId}");
                    print("city name :::::::::::::::::: $chooseValue");
                  },
                  child: DrawHeaderText(
                    textAlign: TextAlign.center,
                    text: context.locale.languageCode == "ar" ? "${item!.nameAr}" : "${item!.nameEn}",
                  ),
                ),
              );
            }).toList(),
          );
        } else if (state is CitiesDropdownError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text("no data found "),
          );
        }
      },
    );
  }
}
