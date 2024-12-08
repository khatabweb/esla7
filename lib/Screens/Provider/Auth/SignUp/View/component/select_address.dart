import '../../bloc/cubit.dart';
import '../../../../../Widgets/Custom_TextFieldTap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressTextFieldTap extends StatefulWidget {
  const AddressTextFieldTap({Key? key}) : super(key: key);

  @override
  State<AddressTextFieldTap> createState() => _AddressTextFieldTapState();
}

class _AddressTextFieldTapState extends State<AddressTextFieldTap> {
  PickResult? selectedPlace;

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerSignUpCubit.get(context);
    return CustomTextFieldTap(
      label: selectedPlace == null
          ? "address".tr()
          : selectedPlace!.formattedAddress ?? "",
      color: Color(0xFFEEEEEE),
      prefixIcon: Image.asset(
        "assets/icons/locationblue.png",
        height: 20,
        width: 20,
        fit: BoxFit.contain,
      ),
      icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor, size: 18),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlacePicker(
              apiKey: "AIzaSyBU6YNVxesC2-qRF2yDgCk7be8QaQz56kQ",
              initialPosition: LatLng(23.8859, 45.0792),
              enableMyLocationButton: true,
              selectInitialPosition: true,
              useCurrentLocation: true,
              onPlacePicked: (value){
                setState(() {
                  selectedPlace = value;
                });
                cubit.address = selectedPlace?.formattedAddress;
                print(cubit.address);
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}