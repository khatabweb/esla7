import 'package:esla7/Screens/User/ProviderProfile/EndService/bloc/cubit.dart';
import 'package:esla7/Screens/User/ProviderProfile/EndService/model/model.dart';
import 'package:esla7/Screens/Widgets/Custom_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'component/OrderDetails.dart';

class SingleOrderCard extends StatelessWidget {
  final CartItemModel cartItemList;
  final int index;
   SingleOrderCard({Key? key,required this.cartItemList, required this.index,}) : super(key: key);

  final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 3.4,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          CartDetails(cartItemList:cartItemList,index: index),
          _AddNotes(cartItemList:cartItemList,index: index,),
        ],
      ),
    );
  }
}


class _AddNotes extends StatelessWidget {
  final int index;
  final CartItemModel cartItemList;
  const _AddNotes({Key? key, required this.index,required this.cartItemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = UserEndListCubit.get(context);
    return CustomTextField(
      verticalPadding: 5,
      lines: 2,
      secureText: false,
      hint: "add_notes".tr(),
      inputType: TextInputType.text,
      color: Colors.white,
      onChanged: (val){
        print(cubit.cartItemList);
        cubit.cartItemList[index].note = val;
        // cartItemList.copyWith(note: val);
        print(cubit.cartItemList);
      },
    );
  }
}

