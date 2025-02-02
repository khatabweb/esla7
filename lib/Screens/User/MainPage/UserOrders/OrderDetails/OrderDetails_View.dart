import '../../../../Widgets/CenterMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../core/API/api_utility.dart';
import '../../../../../core/Theme/color.dart';
import '../../../../CommonScreen/DrawerPages/Views/Complaints_and_suggestions/presentation/screen/Complaints_and_suggestions.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_Background.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_RichText.dart';
import '../../../../Widgets/Custom_RoundedPhoto.dart';
import '../../../BankAccounts/presentation/screen/bank_accounts.dart';
import '../../chat/data/cubit/chat_cubit.dart';
import '../../chat/presentation/screen/view.dart';
import 'data/bloc/cubit.dart';
import 'data/bloc/state.dart';
import 'rate/RateProvider_dialog.dart';
import 'rate/data/bloc/cubit.dart';

class OrderDetailsView extends StatefulWidget {
  final int? orderId;
  final bool? isWaiting, isAccepted, isCompleted;

  OrderDetailsView({
    this.isWaiting,
    this.isAccepted,
    this.isCompleted,
    this.orderId,
  });

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  bool isLoading = true;

  @override
  void initState() {
    context.read<UserOrderDetailsCubit>().orderDetails(widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = UserOrderDetailsCubit.get(context);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "${"order_num".tr()} ${widget.orderId}",
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      body: CustomBackground(child:
          BlocBuilder<UserOrderDetailsCubit, UserOrderDetailsState>(
              builder: (context, state) {
        if (state is UserOrderDetailsLoadingState) {
          return CenterLoading();
        } else if (state is UserOrderDetailsSuccessState) {
          final cubit = state.userOrderDetailsModel;
          RateCubit.get(context).ownerId = cubit.ownerId;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: AnimatedWidgets(
              verticalOffset: 150,
              child: Column(
                children: [
                  //========================= orderDetails ============================
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        _OrderDetail(
                          image:
                              "${ApiUtl.main_image_url}${cubit.imageOwner}",
                          name: "${cubit.ownerName}",
                          rate: 4,
                          orderNumber: cubit.orderNumber,
                        ),
                        _OwnersDetails(
                          companyName: "${cubit.ownerName}",
                          minSalary: "${cubit.minSalary}",
                          serviceName: context.locale.languageCode == "ar"
                              ? "${cubit.servicesNameAr}"
                              : "${cubit.servicesNameEn}",
                          address: "${cubit.address}",
                        ),
                      ],
                    ),
                  ),
    
                  // OrderItemCard(
                  //   image: "${ApiUtl.main_image_url}${cubit.image}",
                  //   subService:  context.locale.languageCode == "ar"
                  //       ? "${cubit.servicesNameAr}"
                  //       : "${cubit.servicesNameEn}",
                  //   quantity: "${cubit.quantity}",
                  //   serviceName:  context.locale.languageCode == "ar"
                  //       ? "${cubit.servicesNameAr}"
                  //       : "${cubit.servicesNameEn}",
                  //   price: "${cubit.price}",
                  //   desc: "${cubit.serviceDesc}",
                  //   note: (cubit.notes == "null" || cubit.notes == null)
                  //       ? "there_are_no_note".tr()
                  //       : "${cubit.notes}",
                  // ),
    
                  //========================= details ============================
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRichText(
                            title: "total_order_price".tr(),
                            subTitle: "${cubit.totalPrice} ${"sar".tr()}"),
                        CustomRichText(
                            title: "detailed_address".tr(),
                            subTitle: "${cubit.address}"),
                        CustomRichText(
                            title: "date".tr(), subTitle: "${cubit.resDate}"),
                        CustomRichText(
                            title: "time".tr(), subTitle: "${cubit.resTime}"),
                      ],
                    ),
                  ),
    
                  widget.isAccepted == true
                      ? AcceptedButtons(
                          ownerName: cubit.ownerName,
                          ownerId: cubit.ownerId,
                          totalPrice: cubit.totalPrice,
                        )
                      : widget.isWaiting == true
                          ? SizedBox()
                          : _RefusedButtons(),
                ],
              ),
            ),
          );
        } else if (state is UserOrderDetailsErrorState) {
          return Center(
            child: Text("${state.error}"),
          );
        } else {
          return CenterLoading();
        }
      })),
    );
  }
}

class _OrderDetail extends StatelessWidget {
  final String? image;
  final String? name;
  final int? rate;
  final int? orderNumber;

  const _OrderDetail({
    Key? key,
    this.image,
    this.name,
    this.rate,
    this.orderNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomRoundedPhoto(
          image: "$image",
          radius: 35,
          borderWidth: 1.5,
          borderColor: ThemeColor.mainGold,
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawHeaderText(
                text: "$name",
                color: ThemeColor.mainGold,
                fontSize: 14,
              ),

              // RatingBar.builder(
              //   initialRating: rate!.toDouble(),
              //   itemSize: 18,
              //   minRating: 0,
              //   direction: Axis.horizontal,
              //   allowHalfRating: true,
              //   ignoreGestures: true,
              //   unratedColor: Colors.grey[300],
              //   itemCount: 5,
              //   itemPadding:
              //   EdgeInsets.symmetric(horizontal: 1),
              //   itemBuilder: (context, _) {
              //     return Image.asset("assets/icons/star.png", color: ThemeColor.mainGold);
              //   },
              //   onRatingUpdate: (rating) {
              //     print(rating);
              //   },
              // ),
            ],
          ),
        ),
        _OrderNumber(number: orderNumber),
      ],
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

class _OwnersDetails extends StatelessWidget {
  final String? companyName;
  final String? minSalary;
  final String? serviceName;
  final String? address;

  const _OwnersDetails({
    Key? key,
    this.companyName,
    this.minSalary,
    this.serviceName,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customListTile(
                context,
                image: "assets/icons/elevator.png",
                text: "$serviceName",
              ),
              _customListTile(
                context,
                image: "assets/icons/money.png",
                text:
                    "${"minimum".tr()} $minSalary ${"sar".tr()}", //الحد الادنى 5 ريال
              ),
            ],
          ),
          // _customListTile(
          //   context,
          //   image: "assets/icons/location.png",
          //   text: "$address",
          // ),
        ],
      ),
    );
  }

  Widget _customListTile(BuildContext context, {String? text, image}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Image.asset(image,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              color: Theme.of(context).primaryColor),
          SizedBox(width: 8),
          DrawSingleText(
            text: text,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}

//======================================================== buttons Caseeeeees ====================================================
class AcceptedButtons extends StatefulWidget {
  final String? ownerName;
  final int? totalPrice;
  final int? ownerId;
  const AcceptedButtons(
      {Key? key, this.ownerName, this.ownerId, this.totalPrice})
      : super(key: key);

  @override
  State<AcceptedButtons> createState() => _AcceptedButtonsState();
}

class _AcceptedButtonsState extends State<AcceptedButtons> {
  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            text: "pay".tr(),
            width: MediaQuery.of(context).size.width / 3.5,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BankAccounts(
                        widget.ownerName, widget.totalPrice, widget.ownerId))),
          ),
          CustomButton(
            text: "rate_provider".tr(),
            width: MediaQuery.of(context).size.width / 3.5,
            isFrame: true,
            fontSize: 12,
            onTap: () {
              showCupertinoDialog(
                  context: context,
                  builder: (_) {
                    return RateProviderDialog(ownerId: widget.ownerId);
                  });
            },
          ),
          BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatStartSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatView(
                      name:
                          "${widget.ownerName == null ? "" : widget.ownerName}",
                      chatId: state.chatId,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ChatLoading) {
                return CenterLoading();
              } else if (state is ChatError) {
                return Center(child: Text(state.error));
              } else if (state is ChatStartSuccess) {
                return CenterMessage("chat_started".tr());
              } else {
                return CustomButton(
                  text: "chat_with_provider".tr(),
                  fontSize: 12,
                  width: MediaQuery.of(context).size.width / 3.5,
                  isFrame: true,
                  onTap: () async {
                    context.read<ChatCubit>().startChat(widget.ownerId);
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class _RefusedButtons extends StatelessWidget {
  const _RefusedButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "report".tr(),
      leftPadding: 15,
      rightPadding: 15,
      width: MediaQuery.of(context).size.width,
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => ComplaintsAndSuggestion())),
    );
  }
}
