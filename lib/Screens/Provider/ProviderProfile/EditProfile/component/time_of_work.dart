import 'package:esla7/Screens/Provider/ProviderProfile/EditProfile/bloc/cubit.dart';
import 'package:esla7/Screens/Provider/ProviderProfile/Profile/Api/model.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TimeOfWork extends StatefulWidget {
  final OwnerProfileModel ownerProfileModel;
  const TimeOfWork({Key? key, required this.ownerProfileModel}) : super(key: key);

  @override
  _TimeOfWorkState createState() => _TimeOfWorkState();
}

class _TimeOfWorkState extends State<TimeOfWork> {
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;

  @override
  void initState() {
    _fromTime = TimeOfDay.now();
    _toTime = TimeOfDay.now();
    super.initState();
  }

  Future _pickFromTime() async {
    final cubit = OwnerUpdateCubit.get(context);
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _fromTime!,
    );
    if (time == null) {
      cubit.from = widget.ownerProfileModel.from;
      print("when 'from' time == null the cubit available from is ::::::::: ${cubit.from}");
    } else {
      cubit.from = time.format(context);
      setState(() {
        _fromTime = time;
      });
    }
  }

  Future _pickToTime() async {
    final cubit = OwnerUpdateCubit.get(context);
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _toTime!,
    );
    if (time == null) {
      cubit.to = widget.ownerProfileModel.to;
      print("when 'to' time == null the cubit available to is ::::::::: ${cubit.to}");
    } else {
      cubit.to = time.format(context);
      setState(() {
        _toTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawHeaderText(text: "from".tr()),
        _pickerContainer(
          context: context,
          hint: _fromTime == null
              ? "time".tr()
              : "${_fromTime!.format(context)}",
          onTap: _pickFromTime,
        ),
        DrawHeaderText(text: "to".tr()),
        _pickerContainer(
          context: context,
          hint: _toTime == null
              ? "time".tr()
              : "${_toTime!.format(context)}",
          onTap: _pickToTime,
        ),
      ],
    );
  }

  Widget _pickerContainer({BuildContext? context, void Function()? onTap, String? hint}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: MediaQuery.of(context!).size.width / 3,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: DrawHeaderText(
            text: hint,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}