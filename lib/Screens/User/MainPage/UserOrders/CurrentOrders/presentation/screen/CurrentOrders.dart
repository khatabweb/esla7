import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../../../API/api_utility.dart';
import '../../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../../Widgets/CenterLoading.dart';
import '../../../../../../Widgets/CenterMessage.dart';
import '../../../OrderDetails/OrderDetails_View.dart';
import '../../data/cubit/user_current_cubit.dart';
import '../widget/single_order.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({Key? key}) : super(key: key);

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  @override
  void initState() {
    context.read<UserCurrentCubit>().getCurrent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCurrentCubit, UserCurrentState>(
        builder: (context, state) {
      if (state is UserCurrentLoading) {
        return CenterLoading();
      } else if (state is UserCurrentSuccess) {
        final model = state.model;

        if (model.order?.length == 0) {
          return CenterMessage("no_current_order".tr());
        } else {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: model.order?.length,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (_, index) {
              var item = model.order?[index];
              print("orderrrrrrrrrr Length ::::::: ${model.order?.length}");
              return AnimatedWidgets(
                verticalOffset: 150,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetailsView(
                          orderId: item?.id,
                          isWaiting: item?.action == "wait" ? true : false,
                          isAccepted: item?.action == "accept" ? true : false,
                        ),
                      ),
                    );
                  },
                  child: SingleOrder(
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
      } else if (state is UserCurrentError) {
        return CenterMessage(state.error);
      } else {
        return CenterMessage("error_message".tr());
      }
    });
  }
}
