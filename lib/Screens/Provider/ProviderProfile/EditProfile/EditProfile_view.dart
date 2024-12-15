import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../API/api_utility.dart';
import '../../../../Theme/color.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_AppBar.dart';
import '../../../Widgets/Custom_BottomSheet.dart';
import '../../../Widgets/Custom_CountryKey.dart';
import '../../../Widgets/Custom_DrawText.dart';
import '../../../Widgets/Custom_SnackBar.dart';
import '../../../Widgets/Custom_TextFormField.dart';
import '../../ProviderMainPage/main_page.dart';
import '../Profile/data/model/model.dart';
import 'component/pick_commercial.dart';
import 'component/time_of_work.dart';
import 'data/bloc/cubit.dart';
import 'data/bloc/state.dart';

class EditProfileView extends StatefulWidget {
  final OwnerProfileModel ownerProfileModel;
  EditProfileView({Key? key, required this.ownerProfileModel})
      : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  Future pickImage() async {
    final cubit = OwnerUpdateCubit.get(context);
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
    final cubit = OwnerUpdateCubit.get(context);
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
      ),
    );
  }

  void onTapSaveBtn() {
    final cubit = OwnerUpdateCubit.get(context);
    if (formKey.currentState!.validate()) {
      cubit.ownerUpdate();
      // showCupertinoDialog(context: context, builder: (context) => SaveDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        context: context,
        appBarTitle: "profile".tr(),
        backgroundColor: Colors.white,
        otherIconWidget: BlocConsumer<OwnerUpdateCubit, OwnerUpdateState>(
          listener: (_, state) {
            if (state is OwnerUpdateErrorState) {
              customSnackBar(_, state.error);
            } else if (state is OwnerUpdateSuccessState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => ProviderMainPage()),
                  (route) => false);
              print(
                  "============================= تم تعديل البيانات بنجاح =========================");
            }
          },
          builder: (context, state) {
            return state is OwnerUpdateLoadingState
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: CenterLoading())
                : _SaveButton(onTap: onTapSaveBtn);
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: AnimatedWidgets(
              verticalOffset: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImageEdit(
                    image:
                        "${ApiUtl.main_image_url}${widget.ownerProfileModel.companyImage}",
                    onTapEdit: imageBottomSheet,
                  ),
                  _Title("company_name".tr()),
                  _NameTextField(hint: widget.ownerProfileModel.companyName),
                  _Title("phone_number".tr()),
                  _PhoneTextField(
                      hint: widget.ownerProfileModel.companyPhone),
                  _Title("email".tr()),
                  _EmailTextField(
                      hint: widget.ownerProfileModel.companyEmail),
                  _Title("minimum_cost".tr()),
                  _MinSalaryTextField(
                      hint: widget.ownerProfileModel.companyMinSalary),
                  _Title("commercial_registration_no".tr()),
                  _CommercialNumberTextField(
                      hint: widget.ownerProfileModel.companyCommerical),
                  _Title("commercial_registration_image".tr()),
                  CommercialImageTextField(
                      ownerProfileModel: widget.ownerProfileModel),
    
                  ///from component
                  _Title("times_of_work".tr()),
                  TimeOfWork(ownerProfileModel: widget.ownerProfileModel),
    
                  ///from component
                  _Title("change_password".tr()),
                  _PasswordTextField(),
                  _PasswordNote(),
                  Divider(),
                  _Title("bank_account_owner_name".tr()),
                  _BankOwnerNameTextField(
                      hint: widget.ownerProfileModel.bankAccountOwner),
                  _Title("bank_name".tr()),
                  _BankNameTextField(hint: widget.ownerProfileModel.bankName),
                  _Title("bank_account_number".tr()),
                  _BankAccountNumberTextField(
                      hint: widget.ownerProfileModel.accountNumber),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _SaveButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: DrawHeaderText(
            text: "save".tr(),
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class _ImageEdit extends StatelessWidget {
  final void Function()? onTapEdit;
  final String? image;
  const _ImageEdit({this.onTapEdit, this.image});

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return AnimatedWidgets(
      verticalOffset: -50,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  height: 120,
                  width: 120,
                  color: Theme.of(context).primaryColor,
                  child: cubit.image == null
                      ? CachedNetworkImage(
                          imageUrl: image!,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.grey,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(cubit.image!.path)),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  onPressed: onTapEdit,
                  icon: Image.asset("assets/icons/camera.png",
                      height: 35, width: 35, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  final String? hint;
  const _NameTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint",
      inputType: TextInputType.name,
      onChanged: (value) {
        if (value == null) {
          cubit.name = hint;
        } else {
          cubit.name = value;
        }
      },
    );
  }
}

class _PhoneTextField extends StatelessWidget {
  final String? hint;
  const _PhoneTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint",
      inputType: TextInputType.phone,
      suffixIcon: CountryCode(),
      validate: (value) {
        if (value!.isNotEmpty && (value.length < 9 || value.length > 9)) {
          return "phone_must_be_nine_numbers".tr();
        }
        return null;
      },
      onChanged: (value) {
        if (value == null) {
          cubit.phone = hint;
        } else {
          cubit.phone = "966$value";
        }
      },
    );
  }
}

class _EmailTextField extends StatelessWidget {
  final String? hint;
  const _EmailTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint",
      inputType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value == null) {
          cubit.email = hint;
        } else {
          cubit.email = value;
        }
      },
    );
  }
}

class _MinSalaryTextField extends StatelessWidget {
  final String? hint;
  const _MinSalaryTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint ${"sar".tr()}",
      suffixIcon: CountryCode(countyCode: "sar".tr()),
      inputType: TextInputType.number,
      onChanged: (value) {
        if (value == null) {
          cubit.minSalary = hint;
        } else {
          cubit.minSalary = value;
        }
      },
    );
  }
}

class _CommercialNumberTextField extends StatelessWidget {
  final String? hint;
  const _CommercialNumberTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint",
      inputType: TextInputType.number,
      onChanged: (value) {
        if (value == null) {
          cubit.commercial = hint;
        } else {
          cubit.commercial = value;
        }
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: true,
      hint: "password".tr(),
      inputType: TextInputType.text,
      validate: (value) {
        if (value!.isEmpty) {
          return "enter_password".tr();
        } else if (value.length < 8) {
          return "password_must_be_eight_characters".tr();
        }
        return null;
      },
      onChanged: (value) {
        cubit.password = value;
      },
    );
  }
}

class _PasswordNote extends StatelessWidget {
  const _PasswordNote({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/icons/help.png",
            height: 12, width: 12, fit: BoxFit.cover, color: Colors.grey[600]),
        SizedBox(width: 5),
        Expanded(
            child: Container(
                child: DrawSingleText(
                    text: "profile_edit_password_note".tr(),
                    color: Colors.grey[600],
                    fontSize: 11))),
      ],
    );
  }
}

class _BankOwnerNameTextField extends StatelessWidget {
  final String? hint;
  const _BankOwnerNameTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint",
      inputType: TextInputType.name,
      onChanged: (value) {
        if (value == null) {
          cubit.bankAccountOwner = hint;
        } else {
          cubit.bankAccountOwner = value;
        }
      },
    );
  }
}

class _BankNameTextField extends StatelessWidget {
  final String? hint;
  const _BankNameTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint",
      inputType: TextInputType.name,
      onChanged: (value) {
        if (value == null) {
          cubit.bankName = hint;
        } else {
          cubit.bankName = value;
        }
      },
    );
  }
}

class _BankAccountNumberTextField extends StatelessWidget {
  final String? hint;
  const _BankAccountNumberTextField({Key? key, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "$hint",
      inputType: TextInputType.number,
      onChanged: (value) {
        if (value == null) {
          cubit.accountNumber = hint;
        } else {
          cubit.accountNumber = value;
        }
      },
    );
  }
}

class _Title extends StatelessWidget {
  final String? text;
  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return DrawHeaderText(
      text: text,
      color: ThemeColor.mainGold,
      fontSize: 14,
    );
  }
}
