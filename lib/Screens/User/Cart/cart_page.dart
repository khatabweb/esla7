import 'package:esla7/Screens/User/Cart/SingleOrder.dart';
import 'package:esla7/Screens/User/Cart/bloc/cubit.dart';
import 'package:esla7/Screens/User/Cart/component/CancelAlert.dart';
import 'package:esla7/Screens/User/MainPage/main_page.dart';
import 'package:esla7/Screens/User/ProviderProfile/EndService/bloc/cubit.dart';
import 'package:esla7/Screens/User/ProviderProfile/OwnerDetails/ProviderProfile.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RichText.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFieldTap.dart';
import 'package:esla7/Screens/Widgets/Custom_popover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bloc/state.dart';
import 'component/ConfirmAlert.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final String language = translator.activeLanguageCode;

  confirmBtnValidation() {
    final cubit = CartCubit.get(context);
    final cubitt = UserEndListCubit.get(context);
    // print("mdckcmc${cubit.listt}");
    cubitt.cartItemList.length == 0
        ? customSnackBar(context, "please_complete_data".tr())
        : (cubit.address == null || cubit.lat == null || cubit.lang == null)
            ? customSnackBar(context, "please_specify_your_address".tr())
            : (cubit.resTime == null || cubit.resDate == null)
                ? customSnackBar(context, "check_the_time_or_date_of_order".tr())
                : cubit.sendOrder(context);
  }

  onTapCancelBtn() {
    final cubit = CartCubit.get(context);
    showCupertinoDialog(context: context, builder: (_) =>
        CancelAlert(
          onTapConfirm: () => Navigator.pop(context),
          onTapDelete: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainPage()), (route) => false);
            // cubit.listt?.clear();
            UserEndListCubit.get(context).cartItemList.clear();
            print("list after clear ${cubit.listt}");
          },
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = UserEndListCubit.get(context);
    final cartCubit = CartCubit.get(context);
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: customAppBar(
            context: context,
            appBarTitle: "cart".tr(),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            showBackButton: false,
          ),
          body: CustomBackground(
            child: SingleChildScrollView(
              child: AnimatedWidgets(
                verticalOffset: 150,
                child: Column(
                  children: [
                    _ListOfOrders(),
                    AddressTextFieldTap(),
                    DateAndTime(),
                    BlocConsumer<CartCubit, CartState>(
                      listener: (_, state){
                        if(state is CartErrorState) customSnackBar(_, state.error);
                        if(state is CartSuccessState){
                          print("order added successfully");
                          showCupertinoDialog(context: context, builder: (_) => ConfirmOrderAlert(
                                onTapHomePage: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainPage(pageIndex: 0)),(route) => false),
                                onTapOrderPage: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainPage(pageIndex: 1)), (route) => false),
                              ),
                          );
                        }
                      },
                      builder: (context, state){
                        return state is CartLoadingState
                            ? CenterLoading()
                            : _ConfirmAndCancel(onTapConfirm: confirmBtnValidation, onTapCancel: onTapCancelBtn);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _ListOfOrders extends StatelessWidget {
  const _ListOfOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = UserEndListCubit.get(context);
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      height: height / 3.4 * cubit.cartItemList.length,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.cartItemList.length,
        itemBuilder: (context, item) {
          return SingleOrderCard(
            cartItemList: cubit.cartItemList[item],
            index: item,
          );
        },
      ),
    );
  }
}



class _ContactWithProvider extends StatelessWidget {
  const _ContactWithProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: width/4,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DrawSingleText(
        text: "how_to_connect_with_provider".tr(),
        fontSize: 13.5,
      ),
    );
  }
}


class _TotalOrderPrice extends StatelessWidget {
  final int? price;
  const _TotalOrderPrice({Key? key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      // height: width/4,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomRichText(title: "total_order_price".tr(), subTitle: "$price ${"sar".tr()}",),
    );
  }
}


//========================================================== AddressTitle ==============================================================
class AddressTextFieldTap extends StatefulWidget {
  @override
  _AddressTextFieldTapState createState() => _AddressTextFieldTapState();
}

class _AddressTextFieldTapState extends State<AddressTextFieldTap> {
  PickResult? selectedPlace;

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    return CustomTextFieldTap(
      height: 45,
      horizontalPadding: 15,
      label: selectedPlace == null ? "detailed_address".tr() : selectedPlace!.formattedAddress ?? "",
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
                cubit.lat = "${selectedPlace?.geometry?.location.lat}";
                cubit.lang = "${selectedPlace?.geometry?.location.lng}";
                print("address :::::::: ${cubit.address}");
                print("lat :::::::: ${cubit.lat}");
                print("lang :::::::: ${cubit.lang}");
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}


//============================================================ DateAndTime ==============================================================
class DateAndTime extends StatefulWidget {
  const DateAndTime({Key? key}) : super(key: key);
  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  String? dateValue, timeValue;
  DateTime? _pickedDate;
  TimeOfDay? _time;

  @override
  void initState() {
    _pickedDate = DateTime.now();
    _time = TimeOfDay.now();
    super.initState();
  }

  Future _pickDate() async {
    final cubit = CartCubit.get(context);
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _pickedDate!,
      firstDate: _pickedDate!,
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date == null) {
      customSnackBar(context, "please_select_service_date".tr());
    }else{
      cubit.resDate = "${_pickedDate?.day}-${_pickedDate?.month}-${_pickedDate?.year}";
      setState(() {
        _pickedDate = date;
        dateValue = "${_pickedDate?.day}-${_pickedDate?.month}-${_pickedDate?.year}";
      });
    }
  }

  Future _pickTime() async{
    final cubit = CartCubit.get(context);
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _time!,
    );
    if (time == null) {
      customSnackBar(context, "please_select_service_time".tr());
    } else {
      cubit.resTime = time.format(context);
      setState(() {
        _time = time;
        timeValue = "${time.format(context)}";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            width: MediaQuery.of(context).size.width/2.3,
            color: Colors.white,
            text: dateValue ?? "date".tr(),
            onTap: _pickDate,
          ),
          CustomButton(
            width: MediaQuery.of(context).size.width/2.3,
            color: Colors.white,
            text: timeValue ?? "time".tr(),
            onTap: _pickTime,
          ),
        ],
      ),
    );
  }
}



//======================================================== ConfirmAndCancel ===============================================================
class _ConfirmAndCancel extends StatelessWidget {
  final VoidCallback? onTapConfirm;
  final VoidCallback? onTapCancel;
  const _ConfirmAndCancel({Key? key, this.onTapConfirm, this.onTapCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            width: MediaQuery.of(context).size.width / 2.3,
            text: "complete_operation".tr(),
            onTap: onTapConfirm,
          ),
          CustomButton(
            width: MediaQuery.of(context).size.width/2.3,
            isFrame: true,
            text: "cancel".tr(),
            onTap: onTapCancel,
          ),
        ],
      ),
    );
  }
}
