import '../../data/bloc/cubit.dart';
import '../../../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TimeOfWork extends StatefulWidget {
  const TimeOfWork({Key? key}) : super(key: key);

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

  Future _pickTimeFrom() async {
    final cubit = OwnerSignUpCubit.get(context);
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _fromTime!,
    );
    if (time == null) {
      cubit.from = _fromTime?.format(context);
      print(
          "when 'from' time == null the cubit available from is ::::::::: ${cubit.from}");
    } else {
      cubit.from = time.format(context);
      setState(() {
        _fromTime = time;
      });
    }
  }

  Future _pickTimeTo() async {
    final cubit = OwnerSignUpCubit.get(context);
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _toTime!,
    );
    if (time == null) {
      cubit.to = _fromTime?.format(context);
      print(
          "when 'to' time == null the cubit available to is ::::::::: ${cubit.to}");
    } else {
      cubit.to = time.format(context);
      setState(() {
        _toTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = OwnerSignUpCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawHeaderText(text: "from".tr()),
        _pickerContainer(
          context: context,
          hint:
              _fromTime == null ? "time".tr() : "${_fromTime!.format(context)}",
          onTap: _pickTimeFrom,
        ),
        DrawHeaderText(text: "to".tr()),
        _pickerContainer(
          context: context,
          hint: _toTime == null ? "time".tr() : "${_toTime!.format(context)}",
          onTap: _pickTimeTo,
        ),
      ],
    );
  }

  Widget _pickerContainer(
      {BuildContext? context, void Function()? onTap, String? hint}) {
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
