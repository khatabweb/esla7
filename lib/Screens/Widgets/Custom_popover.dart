import 'package:esla7/Screens/Widgets/Custom_CheckBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'Custom_DrawText.dart';

class CustomPopOver extends StatelessWidget {
  final Widget? child;
  final List<Widget>? itemList;
  final double? dropWidth;
  final double? dropHeight;
  final double? width;
  final double? horizontalPadding;
  final double? verticalPadding;
  final String? text;
  final Color? color;

  CustomPopOver({
    this.child,
    this.itemList,
    this.dropWidth,
    this.dropHeight,
    this.width,
    this.horizontalPadding,
    this.verticalPadding,
    this.text,
    this.color,
  });

  final String language = translator.activeLanguageCode;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: GestureDetector(
        child: child ??
            _DropDownContainer(
              child: width,
              text: text,
              horizontalPadding: horizontalPadding,
              verticalPadding: verticalPadding,
              color: color,
            ),
        onTap: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => _ListItem(listItem: itemList),
            transitionDuration: Duration(milliseconds: 150),
            direction: PopoverDirection.bottom,
            width: dropWidth ?? 150,
            height: dropHeight ?? 160,
            arrowHeight: 15,
            arrowWidth: 25,
            onPop: () => print("احلي open pop عليك يا عمرو"),
          );
        },
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final List<Widget>? listItem;
  const _ListItem({Key? key, this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Directionality(
        textDirection: translator.activeLanguageCode == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(8),
          children: listItem ?? [],
        ),
      ),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final double? child;
  final double? horizontalPadding;
  final double? verticalPadding;
  final String? text;
  final Color? color;

  const _DropDownContainer({
    this.child,
    this.horizontalPadding,
    this.verticalPadding,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: child ?? MediaQuery.of(context).size.width / 2.5,
      height: 45,
      padding: EdgeInsets.only(right: 20, left: 15),
      margin: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 1)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawSingleText(text: '$text'),
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.09),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.chevron_down,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final void Function()? onTap;
  const DropDownItem({Key? key, this.title, this.subTitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 5),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // translator.activeLanguageCode == "ar"
              //     ? CrossAxisAlignment.end
              //     : CrossAxisAlignment.start,
              children: [
                DrawHeaderText(
                  text: title,
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondary,
                  // textDirection: translator.activeLanguageCode == "ar"
                  //     ? TextDirection.rtl
                  //     : TextDirection.ltr,
                ),
                subTitle != null
                    ? DrawSingleText(
                        text: subTitle,
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.secondary,
                        // textDirection: translator.activeLanguageCode == "ar"
                        //     ? TextDirection.rtl
                        //     : TextDirection.ltr,
                      )
                    : SizedBox(height: 0),
                // Divider (color: Theme.of(context).primaryColor.withOpacity(0.5)),
              ],
            ),
            CustomCheckBox(
              verticalPadding: 0,
              borderColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownAddAddress extends StatelessWidget {
  final void Function()? onTap;
  const DropDownAddAddress({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawHeaderText(
              text: "add_address".tr(),
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
              textDirection: translator.activeLanguageCode == "ar"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            ),
            Icon(Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.secondary),
          ],
        ),
      ),
    );
  }
}
