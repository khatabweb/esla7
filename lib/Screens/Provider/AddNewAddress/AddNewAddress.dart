import '../../Widgets/AnimatedWidgets.dart';
import '../../Widgets/Custom_AppBar.dart';
import '../../Widgets/Custom_Button.dart';
import '../../Widgets/Custom_DrawText.dart';
import '../../Widgets/Custom_TextFieldTap.dart';
import '../../Widgets/Custom_popover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddNewAddress extends StatelessWidget {
  final String? appBarTitle;
  AddNewAddress({Key? key, this.appBarTitle}) : super(key: key);
  final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(
          context: context,
          appBarTitle: appBarTitle!,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: AnimatedWidgets(
            verticalOffset: 150,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                _CityPopOver(),
                AddressTextFieldTap(),
                Expanded(child: _MapContainer()),
                _AddButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CityPopOver extends StatelessWidget {
  const _CityPopOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _city = [
      "مكة المكرمة",
      "ابها",
      "خميس مشيط",
      "جدة",
      "الرياض",
      "المدينة المنورة",
      "الاحساء",
      "الدمام",
    ];

    final double _length = _city.length.toDouble();

    return CustomPopOver(
      width: MediaQuery.of(context).size.width,
      text: "city".tr(),
      color: Color(0xFFEEEEEE),
      dropWidth: MediaQuery.of(context).size.width / 1.1,
      dropHeight: _length * 45,
      itemList: _city.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: () {},
            child: DrawHeaderText(
              textAlign: TextAlign.center,
              text: item,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class AddressTextFieldTap extends StatefulWidget {
  @override
  _AddressTextFieldTapState createState() => _AddressTextFieldTapState();
}

class _AddressTextFieldTapState extends State<AddressTextFieldTap> {
  PickResult? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldTap(
      label: selectedPlace == null
          ? "detailed_address".tr()
          : selectedPlace!.formattedAddress ?? "",
      color: Color(0xFFEEEEEE),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlacePicker(
              apiKey: "AIzaSyBU6YNVxesC2-qRF2yDgCk7be8QaQz56kQ",
              initialPosition: LatLng(23.8859, 45.0792),
              enableMyLocationButton: true,
              selectInitialPosition: true,
              useCurrentLocation: true,
              onPlacePicked: (value) {
                setState(() {
                  selectedPlace = value;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}

class _MapContainer extends StatelessWidget {
  // final PickResult? selectedPlace;
  const _MapContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage("assets/images/maps.png"),
            fit: BoxFit.contain,
          )),
      // child: PlacePicker(
      //   //hintText => on SearchTextField
      //   hintText: "tap to search",
      //   apiKey: "AIzaSyBU6YNVxesC2-qRF2yDgCk7be8QaQz56kQ",
      //   initialPosition: LatLng(23.8859, 45.0792),
      //   enableMyLocationButton: true,
      //   selectInitialPosition: true,
      //   useCurrentLocation: true,
      //   onPlacePicked: (value){
      //     selectedPlace = value;
      //     Navigator.of(context).pop();
      //   },
      // ),
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "save".tr(),
    );
  }
}
