// import 'dart:io';

import 'dart:io';

import 'package:esla7/Screens/User/MainPage/main_page.dart';
import 'package:esla7/Screens/User/Profile/EditProfile/data/bloc/cubit.dart';
import 'package:esla7/Screens/User/Profile/EditProfile/data/bloc/state.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/data/model/profile_model.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_BottomSheet.dart';
import 'package:esla7/Screens/Widgets/Custom_CountryKey.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFormField.dart';
import 'package:esla7/Theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class EditProfile extends StatefulWidget {
  final ProfileModel profileModel;
  EditProfile({Key? key, required this.profileModel}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final String language = translator.activeLanguageCode;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // XFile? _image;
  final _picker = ImagePicker();

  Future pickImage() async {
    final cubit = UserUpdateCubit.get(context);
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
    final cubit = UserUpdateCubit.get(context);
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
      widget: Directionality(
        textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                horizontalTitleGap: 0,
                title: DrawHeaderText(text: "camera".tr()),
                leading: Icon(CupertinoIcons.photo_camera_solid,
                    color: Theme.of(context).primaryColor),
                onTap: () {
                  pickImage();
                  print("::::::::::::::pickImage");
                },
              ),
              ListTile(
                horizontalTitleGap: 0,
                title: DrawHeaderText(text: "photo_gallery".tr()),
                leading: Icon(CupertinoIcons.photo,
                    color: Theme.of(context).primaryColor),
                onTap: () {
                  getImage();
                  print("::::::::::::::getImage");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSaveBtn() {
    final cubit = UserUpdateCubit.get(context);
    if (formKey.currentState!.validate()) {
      cubit.userUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar(
            context: context,
            appBarTitle: "profile".tr(),
            backgroundColor: Colors.white,
            otherIconWidget: BlocConsumer<UserUpdateCubit, UserUpdateState>(
              listener: (_, state) {
                if (state is UserUpdateErrorState) {
                  customSnackBar(_, state.error);
                } else if (state is UserUpdateSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => MainPage()),
                      (route) => false);
                  print(
                      "============================= تم تعديل البيانات بنجاح =========================");
                }
              },
              builder: (context, state) {
                return state is UserUpdateLoadingState
                    ? CenterLoading()
                    : _SaveButton(onTap: onTapSaveBtn);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: AnimatedWidgets(
                verticalOffset: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ImageEdit(
                      image:
                          "http://www.repaairsa.com/${widget.profileModel.image}",
                      onTapEdit: imageBottomSheet,
                    ),
                    _Title("name".tr()),
                    NameTextField(hint: widget.profileModel.name),
                    _Title("phone_number".tr()),
                    PhoneTextField(hint: widget.profileModel.phone),
                    _Title("email".tr()),
                    EmailTextField(hint: widget.profileModel.email),
                    _Title("change_password".tr()),
                    _PasswordTextField(),
                    _PasswordNote(),
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
    final cubit = UserUpdateCubit.get(context);
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
                      ? Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("$image"),
                                fit: BoxFit.cover),
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

class NameTextField extends StatefulWidget {
  final String? hint;
  const NameTextField({Key? key, this.hint}) : super(key: key);

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  @override
  Widget build(BuildContext context) {
    final cubit = UserUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "${widget.hint}",
      inputType: TextInputType.name,
      onChanged: (value) {
        // cubit.name = value == null ? hint : value;
        if (value == null) {
          setState(() {
            cubit.name = widget.hint;
          });
        } else {
          cubit.name = value;
        }
      },
    );
  }
}

class PhoneTextField extends StatefulWidget {
  final String? hint;
  const PhoneTextField({Key? key, this.hint}) : super(key: key);

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    final cubit = UserUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "${widget.hint}",
      inputType: TextInputType.phone,
      suffixIcon: CountryCode(),
      validate: (value) {
        if (value!.isNotEmpty && (value.length < 9 || value.length > 9)) {
          return "phone_must_be_nine_numbers".tr();
        }
        return null;
      },
      onChanged: (value) {
        // cubit.phone = value == null ? hint : value;
        if (value == null) {
          setState(() {
            cubit.phone = widget.hint;
          });
        } else {
          cubit.phone = "966$value";
        }
      },
    );
  }
}

class EmailTextField extends StatefulWidget {
  final String? hint;
  const EmailTextField({Key? key, this.hint}) : super(key: key);

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    final cubit = UserUpdateCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      hint: "${widget.hint}",
      inputType: TextInputType.emailAddress,
      onChanged: (value) {
        // cubit.email = value == null ? hint : value;
        if (value == null) {
          setState(() {
            cubit.email = widget.hint;
          });
        } else {
          cubit.email = value;
        }
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = UserUpdateCubit.get(context);
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

class _Title extends StatelessWidget {
  final String? text;
  const _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return DrawHeaderText(text: text, color: ThemeColor.mainGold, fontSize: 14);
  }
}
