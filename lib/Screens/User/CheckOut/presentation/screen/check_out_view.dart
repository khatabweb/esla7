import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../Theme/color.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_BottomSheet.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_SnackBar.dart';
import '../../../../Widgets/Custom_TextFieldTap.dart';
import '../../../../Widgets/Custom_TextFormField.dart';
import '../../../MainPage/main_page.dart';
import '../../data/bloc/cubit.dart';
import '../../data/bloc/state.dart';
import '../widget/check_success_dialog.dart';

class CheckOutView extends StatefulWidget {
  final String? ownerName;
  final int? totalPrice;
  CheckOutView(this.ownerName, this.totalPrice);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onTapCheckoutBtn() {
    final cubit = CheckoutCubit.get(context);
    if (formKey.currentState!.validate()) {
      cubit.image == null
          ? customSnackBar(context, "bank_transfer_image_required".tr())
          : cubit.checkout(widget.ownerName, widget.totalPrice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        context: context,
        appBarTitle: "checkout".tr(),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: AnimatedWidgets(
            verticalOffset: 150,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Title("bank_name".tr()),
                  _BankNameTextField(),
                  _Title("transfer_account_number".tr()),
                  _SenderAccountNumTextField(),
                  _Title("transformer_name".tr()),
                  _SenderNameTextField(),
                  _Title("bank_transfer_image".tr()),
                  BankTransferImage(),
                  _Title("add_notes".tr()),
                  _NoteTextField(),
                  BlocConsumer<CheckoutCubit, CheckoutState>(
                    listener: (_, state) {
                      if (state is CheckoutErrorState) {
                        customSnackBar(_, state.error);
                      } else if (state is CheckoutSuccessState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MainPage(pageIndex: 1)),
                            (route) => false);
                        showCupertinoDialog(
                            context: context,
                            builder: (_) => CheckoutSuccessDialog());
                        print(
                            "==================== DONE =========================");
                      }
                    },
                    builder: (context, state) {
                      return state is CheckoutLoadingState
                          ? CenterLoading()
                          : _SaveButton(onTap: onTapCheckoutBtn);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BankNameTextField extends StatelessWidget {
  const _BankNameTextField({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "bank_name".tr(),
      inputType: TextInputType.name,
      validate: (value) {
        if (value!.isEmpty) {
          return "bank_name_required".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.bankName = value;
      },
    );
  }
}

class _SenderAccountNumTextField extends StatelessWidget {
  const _SenderAccountNumTextField({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "transfer_account_number".tr(),
      inputType: TextInputType.number,
      validate: (value) {
        if (value!.isEmpty) {
          return "transfer_account_number_required".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.number = value;
      },
    );
  }
}

class _SenderNameTextField extends StatelessWidget {
  const _SenderNameTextField({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "transformer_name".tr(),
      inputType: TextInputType.name,
      validate: (value) {
        if (value!.isEmpty) {
          return "transformer_name_required".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.senderName = value;
      },
    );
  }
}

class BankTransferImage extends StatefulWidget {
  const BankTransferImage({Key? key}) : super(key: key);
  @override
  _BankTransferImageState createState() => _BankTransferImageState();
}

class _BankTransferImageState extends State<BankTransferImage> {
  final _picker = ImagePicker();

  Future pickImage() async {
    final cubit = CheckoutCubit.get(context);
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (photo != null) {
        cubit.image = XFile(photo.path);
      } else {
        print("No image selected!!!!");
      }
    });
  }

  Future getImage() async {
    final cubit = CheckoutCubit.get(context);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        cubit.image = XFile(image.path);
      } else {
        print("No image selected!!!!");
      }
    });
  }

  void imageBottomSheet() {
    customSheet(
        context: context,
        widget: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                horizontalTitleGap: 0,
                title: DrawHeaderText(text: "camera".tr()),
                leading: Icon(CupertinoIcons.photo_camera_solid,
                    color: Theme.of(context).primaryColor),
                onTap: pickImage,
              ),
              ListTile(
                horizontalTitleGap: 0,
                title: DrawHeaderText(text: "photo_gallery".tr()),
                leading: Icon(CupertinoIcons.photo,
                    color: Theme.of(context).primaryColor),
                onTap: getImage,
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    return CustomTextFieldTap(
      verticalPadding: 5,
      color: Color(0xFFEEEEEE),
      label: cubit.image == null ? "example.png" : "${cubit.image!.name}",
      hintColor:
          cubit.image == null ? Colors.grey : Theme.of(context).primaryColor,
      prefixIcon: cubit.image == null
          ? Image.asset(
              "assets/icons/photo.png",
              height: 20,
              width: 20,
              color: Theme.of(context).primaryColor,
              fit: BoxFit.contain,
            )
          : Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: FileImage(File(cubit.image!.path)),
                    fit: BoxFit.cover),
              ),
            ),
      icon: Icon(CupertinoIcons.cloud_upload,
          color: Theme.of(context).primaryColor),
      onTap: imageBottomSheet,
    );
  }
}

class _NoteTextField extends StatelessWidget {
  const _NoteTextField({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = CheckoutCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "add_notes".tr(),
      inputType: TextInputType.name,
      onChanged: (value) {
        cubit.note = value;
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _SaveButton({Key? key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "checkout".tr(),
      bottomPadding: 15,
      width: MediaQuery.of(context).size.width,
      onTap: onTap,
    );
  }
}

class _Title extends StatelessWidget {
  final String? text;
  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return DrawHeaderText(text: text, color: ThemeColor.mainGold, fontSize: 14);
  }
}
