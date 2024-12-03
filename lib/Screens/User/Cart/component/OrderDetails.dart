import 'dart:io';
import 'package:esla7/Screens/User/ProviderProfile/EndService/bloc/cubit.dart';
import 'package:esla7/Screens/User/ProviderProfile/EndService/model/model.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Widgets/Custom_BottomSheet.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RichText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CartDetails extends StatefulWidget {
  final CartItemModel cartItemList;
  final int index;
  const CartDetails({
    Key? key,
    required this.cartItemList,
    required this.index,
  }) : super(key: key);

  @override
  _CartDetailsState createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  int? counter = 1, singlePrice = 80, totalPrice;
  XFile? _image;
  final _picker = ImagePicker();

  Future pickImage() async {
    final cubit = UserEndListCubit.get(context);
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (photo != null) {
        _image = XFile(photo.path);
        cubit.cartItemList[widget.index].image = XFile(photo.path);
      } else {
        print("No image selected!!!!");
      }
    });
    // cubit.cartItemList[widget.index].image = _image;
    // widget.cartItemList.copyWith(image: _image);
    print(cubit.cartItemList);
  }

  Future getImage() async {
    final cubit = UserEndListCubit.get(context);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = XFile(image.path);
        cubit.cartItemList[widget.index].image = XFile(image.path);
      } else {
        print("No image selected!!!!");
      }
    });
    // cubit.cartItemList[widget.index].image = _image;
    // =widget.cartItemList.copyWith(image: _image);
    print(cubit.cartItemList);
  }

  void imageBottomSheet() {
    customSheet(
        context: context,
        widget: Directionality(
          textDirection: translator.activeLanguageCode == "ar"
              ? TextDirection.rtl
              : TextDirection.ltr,
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = UserEndListCubit.get(context);
    return Container(
      height: height / 6,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: _image == null
                        ? Center(
                            child: Image.asset("assets/icons/photo.png",
                                height: 25, width: 25, fit: BoxFit.contain),
                          )
                        : Center(
                            child: Image.file(File(_image!.path),
                                width: 60, height: 60, fit: BoxFit.cover)),
                  ),
                ),
                onTap: imageBottomSheet,
              ),
              DrawSingleText(
                text: "add_photo".tr(),
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
            ],
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawHeaderText(
                            text: "${widget.cartItemList.name}",
                            color: ThemeColor.mainGold,
                            fontSize: 14),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: _MiniContainer(),
                              onTap: () {
                                setState(() {
                                  counter = (counter! + 1);
                                  totalPrice =
                                      widget.cartItemList.price! * counter!;
                                });
                                print(cubit.cartItemList);
                                cubit.cartItemList[widget.index].quantity =
                                    counter;
                                // =widget.cartItemList.copyWith(quantity: counter);
                                print(cubit.cartItemList);
                              },
                            ),
                            _MiniContainer(
                              titled: true,
                              title: "$counter",
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                            ),
                            InkWell(
                              child: _MiniContainer(minus: true),
                              onTap: () {
                                if (counter == 1) {
                                  setState(() {
                                    counter = 1;
                                    totalPrice =
                                        widget.cartItemList.price! * counter!;
                                  });
                                } else {
                                  setState(() {
                                    counter = (counter! - 1);
                                    totalPrice =
                                        widget.cartItemList.price! * counter!;
                                  });
                                  print(cubit.cartItemList);
                                  cubit.cartItemList[widget.index].quantity =
                                      counter;
                                  // =widget.cartItemList.copyWith(quantity: counter,);
                                  print(cubit.cartItemList);
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawHeaderText(
                            text: "${widget.cartItemList.name ?? ''}",
                            fontSize: 14),
                        CustomRichText(
                          title: "price".tr(),
                          subTitle:
                              "${totalPrice ?? widget.cartItemList.price} ${"sar".tr()}",
                          // ${totalPrice == null ? singlePrice : totalPrice}
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2),
                DrawSingleText(
                  text: "${widget.cartItemList.serviceDesc}".tr(),
                  fontSize: 12,
                  textHeight: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniContainer extends StatelessWidget {
  final Color? color;
  final Color? titleColor;
  final String? title;
  final bool? minus, titled;
  const _MiniContainer(
      {this.color, this.title, this.titleColor, this.minus, this.titled});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: titled == true
            ? DrawSingleText(
                text: title ?? "",
                fontSize: 12,
                color: Theme.of(context).primaryColor,
              )
            : Icon(minus == true ? CupertinoIcons.minus : CupertinoIcons.add,
                size: 15, color: Colors.white),
      ),
    );
  }
}
