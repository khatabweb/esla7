import 'package:flutter/material.dart';

void openCommonBottomSheet(BuildContext context,
    {bool isDismissible = true, Widget? destination}) {
  showModalBottomSheet(
    context: context,
    enableDrag: isDismissible,
    isDismissible: isDismissible,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
    ),
    builder: (ctx) => ConstrainedBox(
      constraints: BoxConstraints.expand(width: 100, height: 77),
      child: DraggableScrollableSheet(
        initialChildSize: 0.98,
        minChildSize: 0.88,
        builder: (ctx, scrollCtrl) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            /// Top dragging notch.
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                height: 5,
                width: MediaQuery.of(context).size.width / 5,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
            ),
            Expanded(child: destination!),
          ],
        ),
      ),
    ),
  );
}
