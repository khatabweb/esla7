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
import 'data/cubit/user_finished_cubit.dart';

class FinishedOrders extends StatefulWidget {
  const FinishedOrders({Key? key}) : super(key: key);

  @override
  State<FinishedOrders> createState() => _FinishedOrdersState();
}

class _FinishedOrdersState extends State<FinishedOrders> {
   

  @override
  void initState() {
    context.read<UserFinishedCubit>().getFinished();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFinishedCubit, UserFinishedState>(
      builder: (context, state) {
        if (state is UserFinishedLoading) {
          return CenterLoading();
        } else if (state is UserFinishedSuccess) {
          final model = state.userFinishedModel;
          if (model.order?.length == 0) {
            return CenterMessage("no_finished_order".tr());
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: model.order?.length,
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemBuilder: (_, index) {
                var item = model.order?[index];
                return AnimatedWidgets(
                  verticalOffset: 150,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetailsView(
                          orderId: item?.id,
                          isCompleted:
                              item?.action == "finished" ? true : false,
                        ),
                      ),
                    ),
                    child: _SingleOrder(
                      image: "${ApiUtl.main_image_url}${item?.image}",
                      orderId: item?.id,
                      address: "${item?.address}",
                      date: "${item?.resDate}",
                      state: "${item?.action}",
                    ),
                  ),
                );
              },
            );
          }
        } else if (state is UserFinishedError) {
          return CenterMessage(state.error);
        } else {
          return CenterMessage("no found data");
        }
      },
    );
  }
}

class _SingleOrder extends StatelessWidget {
  final String? image;
  final int? orderId;
  final String? address;
  final String? date;
  final String? state;

  const _SingleOrder({
    Key? key,
    this.image,
    this.orderId,
    this.address,
    this.date,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _CompleteState(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
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