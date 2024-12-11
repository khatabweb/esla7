import 'package:flutter/material.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';

class CustomCheckBox extends StatefulWidget {
  final bool? isChecked;
  final Color? selectedColor, borderColor;
  final double? height, width, verticalPadding;
  final void Function()? onTap;

  CustomCheckBox({
    this.isChecked,
    this.selectedColor,
    this.height,
    this.width,
    this.verticalPadding,
    this.onTap,
    this.borderColor,
  });

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        width: widget.width ?? 18,
        height: widget.height ?? 18,
        margin: EdgeInsets.only(top: widget.verticalPadding ?? 15, bottom: widget.verticalPadding ?? 15, left: 5, right: 5),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: _isSelected
              ? null
              : Border.all(
                  color: widget.borderColor ?? Theme.of(context).primaryColor,
                  width: 1,
                ),
        ),
        child: _isSelected
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : null,
      ),
    );
  }
}
