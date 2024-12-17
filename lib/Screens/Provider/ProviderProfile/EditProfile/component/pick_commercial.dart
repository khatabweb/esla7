import 'dart:io';
import '../../../../../core/API/api_utility.dart';
import '../data/bloc/cubit.dart';
import '../../Profile/data/model/model.dart';
import '../../../../Widgets/Custom_BottomSheet.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_TextFieldTap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CommercialImageTextField extends StatefulWidget {
  final String? hint;
  final OwnerProfileModel ownerProfileModel;
  const CommercialImageTextField(
      {Key? key, this.hint, required this.ownerProfileModel})
      : super(key: key);

  @override
  State<CommercialImageTextField> createState() =>
      _CommercialImageTextFieldState();
}

class _CommercialImageTextFieldState extends State<CommercialImageTextField> {
  final _picker = ImagePicker();

  Future pickImage() async {
    final cubit = OwnerUpdateCubit.get(context);
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (photo != null) {
        cubit.ownerImage = XFile(photo.path);
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
        cubit.ownerImage = XFile(image.path);
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
    final cubit = OwnerUpdateCubit.get(context);
    return CustomTextFieldTap(
      verticalPadding: 5,
      color: Color(0xFFEEEEEE),
      hintColor: Theme.of(context).colorScheme.secondary,
      label: cubit.ownerImage == null
          ? "${widget.ownerProfileModel.commericalImage}"
          : "${cubit.ownerImage!.name}",
      prefixIcon: cubit.ownerImage == null
          ? Image.network(
              "${ApiUtl.main_image_url}${widget.ownerProfileModel.commericalImage}",
              height: 20,
              width: 20,
              // color: Theme.of(context).primaryColor,
              fit: BoxFit.cover,
            )
          : Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: FileImage(File(cubit.ownerImage!.path)),
                    fit: BoxFit.cover),
              ),
            ),
      icon: Icon(CupertinoIcons.cloud_upload,
          color: Theme.of(context).primaryColor),
      onTap: imageBottomSheet,
    );
  }
}
