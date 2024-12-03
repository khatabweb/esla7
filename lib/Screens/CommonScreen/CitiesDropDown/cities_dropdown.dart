import 'package:esla7/Screens/CommonScreen/CitiesDropDown/Api/cities_controller.dart';
import 'package:esla7/Screens/CommonScreen/CitiesDropDown/Api/cities_model.dart';
import 'package:esla7/Screens/Provider/Auth/SignUp/bloc/cubit.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_popover.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CitiesDropdown extends StatefulWidget {
  late  int? cityId;
  final Color? color;
  final bool? ownerRegister;
  final double? horizontalPadding;
  CitiesDropdown({Key? key, this.cityId, this.color, this.horizontalPadding, this.ownerRegister,}) : super(key: key);

  @override
  State<CitiesDropdown> createState() => _CitiesDropdownState();
}

class _CitiesDropdownState extends State<CitiesDropdown> {
  final lang = translator.activeLanguageCode;
  CitiesModel _citiesModel = CitiesModel();
  CitiesController _citiesController = CitiesController();
  bool _isLoading = true;
  String? chooseValue;

  void getCities() async {
    _citiesModel = await _citiesController.getCity();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registerCubit = OwnerSignUpCubit.get(context);
    return _isLoading
        ? CenterLoading()
        : CustomPopOver(
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
                    print(item!.id);
                    lang == "ar"
                        ? chooseValue = item.nameAr
                        : chooseValue = item.nameEn;
                    widget.ownerRegister == true
                        ? registerCubit.cityId = item.id
                        : widget.cityId = item.id;
                    setState(() {});
                    print("city ID :::::::::::::::::: ${item.id}");
                    print("owner register city id :::::::::::::::::: ${registerCubit.cityId}");
                    print("city name :::::::::::::::::: $chooseValue");
                  },
                  child: DrawHeaderText(
                    textAlign: TextAlign.center,
                    text: lang == "ar" ? "${item!.nameAr}" : "${item!.nameEn}",
                  ),
                ),
              );
            }).toList(),
          );
  }
}