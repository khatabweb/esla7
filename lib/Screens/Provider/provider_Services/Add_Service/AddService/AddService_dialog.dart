import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_CountryKey.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFormField.dart';
import 'package:esla7/Screens/Widgets/Custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../Service_Name_List/service_name.dart';
import '../Sub_Service_List/sub_service.dart';
import 'add_success_dialog.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';

class AddServiceDialog extends StatefulWidget {
  final int? mainServiceId;
  const AddServiceDialog({Key? key, this.mainServiceId}) : super(key: key);

  @override
  State<AddServiceDialog> createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<AddServiceDialog> {
  final formKey = GlobalKey<FormState>();

  void _checkValidation(){
    final cubit = AddServiceCubit.get(context);
    if (formKey.currentState!.validate()) {
      cubit.subServiceId == null
          ? customSnackBar(context, "please_select_your_sub_service".tr())
          : cubit.serviceNameId == null
              ? customSnackBar(context, "please_select_your_service_name".tr())
              : cubit.ownerAddService();
    }
  }


  @override
  Widget build(BuildContext context) {
    final cubit = AddServiceCubit.get(context);
    return CustomDialog(
      title: "add_service".tr(),
      contact: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SubServiceType(mainServiceId: widget.mainServiceId),
              ServiceName(),
              _ServicePriceTextField(),
              _ServiceDescTextField(),

              BlocConsumer<AddServiceCubit, AddServiceState>(
                listener: (_, state){
                  if(state is AddServiceErrorState){
                    customSnackBar(_, state.error);
                  }else if(state is AddServiceSuccessState){
                    print("========== تم الخدمة بنجاح ========");
                    Navigator.pop(context);
                    showCupertinoDialog(context: context, builder: (_) => AddSuccessDialog());
                  }
                },
                builder: (context, state){
                  return state is AddServiceLoadingState
                      ? CenterLoading()
                      : _ConfirmButtons(onTapConfirm: _checkValidation);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class _ServicePriceTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = AddServiceCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "service_price".tr(),
      hint: "20 ${"sar".tr()}",
      suffixIcon: CountryCode(countyCode: "sar".tr()),
      inputType: TextInputType.number,
      validate: (value){
        if(value!.isEmpty) {
          return "enter_service_price".tr();
        }
      },
      onChanged: (value){
        cubit.price = int.parse("$value");
      },
    );
  }
}


class _ServiceDescTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = AddServiceCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      lines: 2,
      label: "service_desc".tr(),
      inputType: TextInputType.text,
      validate: (value){
        if(value!.isEmpty) {
          return "enter_service_desc".tr();
        }
      },
      onChanged: (value){
        cubit.desc = value;
      },
    );
  }
}


class _ConfirmButtons extends StatelessWidget {
  final VoidCallback? onTapConfirm;
  const _ConfirmButtons({Key? key, this.onTapConfirm}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "add".tr(),
            onTap: onTapConfirm,
          ),

          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            rightPadding: 5,
            leftPadding: 5,
            text: "back".tr(),
            isFrame: true,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}