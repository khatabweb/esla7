import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../API/api_utility.dart';
import '../../../../../Theme/color.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/CenterMessage.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_RoundedPhoto.dart';
import '../OrderDetails/OrderDetails_View.dart';
import 'data/cubit/finished_provider_order_cubit.dart';


class FinishedProviderOrders extends StatefulWidget {
  const FinishedProviderOrders({Key? key}) : super(key: key);

  @override
  State<FinishedProviderOrders> createState() => _FinishedProviderOrdersState();
}

class _FinishedProviderOrdersState extends State<FinishedProviderOrders> {
  @override
  void initState() {
    context.read<FinishedProviderOrderCubit>().getFinishedOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinishedProviderOrderCubit, FinishedProviderOrderState>(
        builder: (context, state) {
      if (state is FinishedProviderOrderLoading) {
        return CenterLoading();
      } else if (state is FinishedProviderOrderError) {
        return CenterMessage(state.errorMessage);
      } else if (state is FinishedProviderOrderSuccess) {
        final model = state.ownerFinishedModel;
        if (model.order?.length == 0) {
          return CenterMessage("no_finished_order".tr());
        } else {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: model.order?.length,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (_, index) {
              return AnimatedWidgets(
                  verticalOffset: 150,
                  child: _SingleOrderItem(
                    image:
                        "${ApiUtl.main_image_url}${model.order?[index]?.image}",
                    orderId: model.order?[index]?.id,
                    address: model.order?[index]?.address,
                    date: model.order?[index]?.resDate,
                    state: model.order?[index]?.action,
                  ));
            },
          );
        }
      } else {
        return CenterMessage("no data found ");
      }
    });
  }
}

class _SingleOrderItem extends StatelessWidget {
  final String? image;
  final int? orderId;
  final String? address;
  final String? date;
  final String? state;

  const _SingleOrderItem({
    Key? key,
    this.image,
    this.orderId,
    this.address,
    this.date,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderDetailsView(
            orderId: orderId,
            isCompleted: state == "finished" ? true : false,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRoundedPhoto(
              image: "$image",
              radius: 30,
              borderWidth: 0,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _OrderNumber(number: orderId),
                              SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/icons/date.png",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.cover,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                      child: DrawSingleText(
                                          text: "$date",
                                          fontSize: 14,
                                          color: Colors.grey[700])),
                                ],
                              ),
                              // DrawSingleText(text: "$date", fontSize: 14, color: Colors.grey[700]),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [_CompleteState()],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/location.png",
                          height: 22,
                          width: 22,
                          fit: BoxFit.cover,
                          color: Colors.grey[700],
                        ),
                        SizedBox(width: 5),
                        Expanded(
                            child: DrawSingleText(
                                text: "$address", color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderNumber extends StatelessWidget {
  final int? number;
  const _OrderNumber({this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFFdce6f2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawHeaderText(text: "order_number".tr(), fontSize: 12),
          DrawHeaderText(
              text: "$number", color: ThemeColor.mainGold, fontSize: 12),
        ],
      ),
    );
  }
}

class _CompleteState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width / 3.8,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFFf6a6ac),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DrawHeaderText(
          text: "rejected".tr(),
          fontSize: 12,
        ),
      ),
    );
  }
}

// class _ExpiredState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 35,
//       width: MediaQuery.of(context).size.width / 3.8,
//       padding: EdgeInsets.symmetric(horizontal: 5),
//       decoration: BoxDecoration(
//         color: Color(0xFFeab881),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: DrawHeaderText(
//           text: "expired".tr(),
//           fontSize: 12,
//         ),
//       ),
//     );
//   }
// }
