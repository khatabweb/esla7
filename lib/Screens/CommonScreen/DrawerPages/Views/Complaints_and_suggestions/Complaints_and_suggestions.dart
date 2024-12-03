// import 'dart:io';

import 'dart:io';

import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/Complaints_and_suggestions/Bloc/state.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/Complaints_and_suggestions/sendSuccessfully_dialog.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_BottomSheet.dart';
import 'package:esla7/Screens/Widgets/Custom_CountryKey.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_SnackBar.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFieldTap.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFormField.dart';
import 'package:esla7/Screens/Widgets/Custom_popover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'Bloc/cubit.dart';

class ComplaintsAndSuggestion extends StatefulWidget {
  ComplaintsAndSuggestion({Key? key}) : super(key: key);

  @override
  State<ComplaintsAndSuggestion> createState() => _ComplaintsAndSuggestionState();
}

class _ComplaintsAndSuggestionState extends State<ComplaintsAndSuggestion> {
  final _formKey = GlobalKey<FormState>();
  final String language = translator.activeLanguageCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ComplaintsCubit.get(context);
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: customAppBar(
            context: context,
            appBarTitle: "feedback".tr(),
            backgroundColor: Colors.white,
            otherIconWidget: BlocConsumer<ComplaintsCubit, ComplaintsState>(
              listener: (_, state){
                if(state is ComplaintsErrorState){
                  customSnackBar(_, state.error);
                }else if(state is ComplaintsSuccessState){
                  Navigator.pop(_);
                  showCupertinoDialog(context: _, builder: (_){
                    return SentSuccessfullyDialog();
                  });
                  cubit.image = null;
                  print("::::::::::::::::::::::::: sent successfully ::::::::::::");
                }
              },
              builder: (context, state){
                return state is ComplaintsLoadingState
                      ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: CenterLoading(),
                      )
                      : _SendButton(
                          onTap: () {
                            if(_formKey.currentState!.validate()){
                              cubit.sendComplaints();
                            }
                          },
                        );
                },
            ),
            fontSize: language == "ar" ? 18 : 15
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: AnimatedWidgets(
              verticalOffset: 150,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    MessageTypeDrop(),
                    _NameTextField(),
                    _PhoneTextField(),
                    _OrderNumTextField(),
                    _MessageTextField(),
                    ComplaintImageTap(),
                    _FeedBackVector(),
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


class MessageTypeDrop extends StatefulWidget {
  @override
  _MessageTypeDropState createState() => _MessageTypeDropState();
}

class _MessageTypeDropState extends State<MessageTypeDrop> {
  String? valueChoose;

  @override
  Widget build(BuildContext context) {
    final cubit = ComplaintsCubit.get(context);
    return CustomPopOver(
      text: valueChoose ?? "message_type".tr(),
      width: MediaQuery.of(context).size.width,
      color: Color(0xFFEEEEEE),
      dropWidth: MediaQuery.of(context).size.width / 1.1,
      dropHeight: 110,
      itemList: [
        TextButton(
          onPressed: () {
            setState(() {
              valueChoose = "complaint".tr();
            });
            cubit.type = "comp";
          },
          child: DrawSingleText(
            text: "complaint".tr(),
          ),
        ),

        TextButton(
          onPressed: () {
            setState(() {
              valueChoose = "suggestion".tr();
            });
            cubit.type = "suggest";
          },
          child: DrawSingleText(
            text: "suggestion".tr(),
          ),
        ),
      ],
    );
  }
}


class _NameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = ComplaintsCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "name".tr(),
      inputType: TextInputType.name,
      validate: (value){
        if(value!.isEmpty){
          return "enter_name".tr();
        }
      },
      onChanged: (value){
        cubit.name = value;
      },
    );
  }
}


class _PhoneTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = ComplaintsCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "phone_number".tr(),
      inputType: TextInputType.phone,
      suffixIcon: CountryCode(),
      onChanged: (value){
        cubit.phone = value;
      },
    );
  }
}


class _OrderNumTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = ComplaintsCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      label: "order_num".tr(),
      inputType: TextInputType.number,
      onChanged: (value){
        cubit.orderID = int.parse("$value");
        print("order id :::::::::::::: ${cubit.orderID}");
      },
    );
  }
}


class _MessageTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = ComplaintsCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      secureText: false,
      lines: 3,
      label: "message".tr(),
      inputType: TextInputType.text,
      validate: (value){
        if(value!.isEmpty){
          return "enter_your_comp_or_sug".tr();
        }
      },
      onChanged: (value){
        cubit.message = value;
      },
    );
  }
}


class ComplaintImageTap extends StatefulWidget {
  @override
  _ComplaintImageTapState createState() => _ComplaintImageTapState();
}
class _ComplaintImageTapState extends State<ComplaintImageTap> {
  final String language = translator.activeLanguageCode;
  XFile? _image;
  final _picker = ImagePicker();

  Future pickImage() async {
    final cubit = ComplaintsCubit.get(context);
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (photo != null){
        cubit.image = XFile(photo.path);
      } else {
        print("No image selected!!!!");
      }
    });
  }

  Future getImage() async {
    final cubit = ComplaintsCubit.get(context);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null){
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
                  leading: Icon(CupertinoIcons.photo_camera_solid, color: Theme.of(context).primaryColor),
                  onTap: pickImage,
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  title: DrawHeaderText(text: "photo_gallery".tr()),
                  leading: Icon(CupertinoIcons.photo, color: Theme.of(context).primaryColor),
                  onTap: getImage,
                ),
              ],
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ComplaintsCubit.get(context);
    return CustomTextFieldTap(
      verticalPadding: 5,
      color: Color(0xFFEEEEEE),
      label: cubit.image == null
          ? "${"complaint_image".tr()} (${"optional".tr()})"
          : "${cubit.image!.name}",
      prefixIcon: cubit.image == null
          ? null
          : Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: FileImage(File(cubit.image!.path)),
                  fit: BoxFit.cover
                ),
              ),
            ),
      icon: Icon(CupertinoIcons.cloud_upload ,color: Theme.of(context).primaryColor),
      onTap: imageBottomSheet,
    );
  }
}


class _FeedBackVector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage("assets/images/feedback.png"),
            fit: BoxFit.contain,
          )
      ),
      // child: Image.asset("assets/images/map.png", fit: BoxFit.cover),
    );
  }
}


class _SendButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _SendButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 75,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: DrawHeaderText(text: "send".tr(),color: Colors.white)),
      ),
    );
  }
}