import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/CenterMessage.dart';
import '../../../../../Widgets/Custom_AppBar.dart';
import '../../../../../Widgets/Custom_TextFieldTap.dart';
import '../../../EndService/presentation/screen/EndService.dart';
import '../../data/bloc/cubit.dart';
import '../../data/bloc/state.dart';

class SubService extends StatefulWidget {
  final int? ownerId;

  SubService({Key? key, this.ownerId}) : super(key: key);

  @override
  State<SubService> createState() => _SubServiceState();
}

class _SubServiceState extends State<SubService> {
  @override
  void initState() {
    // userSubService().then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    context.read<UserSubListCubit>().userSubService(ownerId: widget.ownerId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = UserSubListCubit.get(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(
            context: context,
            appBarTitle: "choose_service_type".tr(),
            backgroundColor: Colors.white),
        body: BlocBuilder<UserSubListCubit, UserSubListState>(
          builder: (context, state) {
            if (state is UserSubListLoadingState) {
              return CenterLoading();
            } else if (state is UserSubListErrorState) {
              return CenterMessage(state.error);
            } else if (state is UserSubListSuccessState) {
              final model = state.subListModel;
              if (model.services?.length == 0) {
                return CenterMessage("there_are_no_sub_services_now".tr());
              } else {
                return AnimatedWidgets(
                  verticalOffset: 150,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: model.services?.length,
                    itemBuilder: (context, index) {
                      var item = model.services?[index];
                      return _ServiceCard(
                        text: context.locale.languageCode == "ar"
                            ? "${item?.nameAr}"
                            : "${item?.nameEn}",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EndService(
                              serviceId: item?.id,
                              ownerId: widget.ownerId,
                              appBarTitle: context.locale.languageCode == "ar"
                                  ? "${item?.nameAr}"
                                  : "${item?.nameEn}",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            } else {
              return CenterLoading();
            }
          },
        ));
  }
}

class _ServiceCard extends StatelessWidget {
  final String? text;
  final void Function()? onTap;

  const _ServiceCard({Key? key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldTap(
      width: MediaQuery.of(context).size.width,
      height: 60,
      horizontalPadding: 15,
      color: Color(0xFFEEEEEE),
      label: text,
      labelSize: 14,
      fontFamily: "JannaLT-Bold",
      onTap: onTap,
    );
  }
}
