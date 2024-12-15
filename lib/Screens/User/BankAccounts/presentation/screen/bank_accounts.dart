// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_Background.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../CheckOut/presentation/screen/check_out_view.dart';
import '../../data/cubit/bank_account_cubit.dart';

class BankAccounts extends StatefulWidget {
  final String? ownerName;
  final int? totalPrice;
  final int? ownerId;
  const BankAccounts(this.ownerName, this.totalPrice, this.ownerId);

  @override
  State<BankAccounts> createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  @override
  void initState() {
    BankAccountCubit.get(context).getBanks(ownerId: widget.ownerId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "bank_accounts".tr(),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      body: CustomBackground(
        child: AnimatedWidgets(
          verticalOffset: 150,
          child: BlocBuilder<BankAccountCubit, BankAccountState>(
            builder: (context, state) {
              if (state is BankAccountLoading) {
                return CenterLoading();
              } else if (state is BankAccountSuccess) {
                final _model = state.bankAccountsModel;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // var item = _model.banksList?[index];
                          return _SingleAccountCard(
                            // image: _model.,
                            ownerName: _model.accountNumber,
                            bankName: _model.bankName,
                            ibanNumber: _model.bankAccountOwner,
                          );
                        },
                      ),
                    ),
                    CustomButton(
                      text: "pay".tr(),
                      rightPadding: 15,
                      leftPadding: 15,
                      bottomPadding: 15,
                      width: MediaQuery.of(context).size.width,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CheckOutView(
                                  widget.ownerName, widget.totalPrice))),
                    ),
                  ],
                );
              }
              return CenterLoading();
            },
          ),
        ),
      ),
    );
  }
}

class _SingleAccountCard extends StatelessWidget {
  // final String? image;
  final String? ownerName;
  final String? bankName;
  final String? ibanNumber;
  const _SingleAccountCard({
    Key? key,
    // this.image,
    this.ownerName,
    this.bankName,
    this.ibanNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 6.5,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Container(
          //   height: height,
          //   width: width / 4.5,
          //   child: CachedNetworkImage(
          //     imageUrl: image!,
          //     placeholder: (context, url) => CircularProgressIndicator(),
          //     errorWidget: (context, url, error) => Icon(
          //       Icons.error,
          //       color: Colors.grey,
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //     color: Colors.amber,
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          // ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawSingleText(text: "$ownerName", fontSize: 13),
                  DrawHeaderText(text: "$bankName", fontSize: 16),
                  DrawHeaderText(text: "$ibanNumber", fontSize: 13),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
