import '../../../API/api_utility.dart';
import '../ProviderProfile/OwnerDetails/ProviderProfile.dart';
import 'owner_bloc/state.dart';
import '../../Widgets/AnimatedWidgets.dart';
import '../../Widgets/CenterLoading.dart';
import '../../Widgets/Custom_AppBar.dart';
import '../../Widgets/Custom_Background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'owner_bloc/cubit.dart';
import 'widgets/SingleProviderCard.dart';

class SingleSection extends StatefulWidget {
  final String? serviceName;
  final int? mainServiceId;
  const SingleSection({Key? key, this.mainServiceId, this.serviceName})
      : super(key: key);

  @override
  State<SingleSection> createState() => _SingleSectionState();
}

class _SingleSectionState extends State<SingleSection> {
  final String lang = translator.activeLanguageCode;
  bool loading = true;

  @override
  void initState() {
    context.read<OwnersCubit>().getAdvertisers();
    context.read<OwnersCubit>().getOwners(widget.mainServiceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "${widget.serviceName}",
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        body: CustomBackground(
          child: BlocBuilder<OwnersCubit, OwnersState>(
            builder: (context, state) {
              if (state is OwnersLoadingState) {
                return CenterLoading();
              } else if (state is OwnersSuccessState) {
                final _ownersModel = OwnersCubit.get(context).ownersModel;
                final _advertisersModel =
                    OwnersCubit.get(context).advertisersModel;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: AnimatedWidgets(
                    verticalOffset: 50,
                    child: Column(
                      children: [
                        ///::::::::::::: Advertiser List ::::::::::::::::
                        Container(
                          height: height * 0.15,
                          // height: height *
                          //         0.15 *
                          //         _advertisersModel.advertisers!.length
                          //             .toDouble() +
                          //     (_advertisersModel.advertisers!.length
                          //             .toDouble() *
                          //         10),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _advertisersModel.advertisers!.length,
                            itemBuilder: (context, index) {
                              var item = _advertisersModel.advertisers![index];
                              return SingleProviderCard(
                                isGolden: true,
                                name: item!.ownerName,
                                city: lang == "ar"
                                    ? item.city!.nameAr
                                    : item.city!.nameEn,
                                rate: item.rate ?? 0,
                                serviceName: lang == "ar"
                                    ? item.service!.nameAr
                                    : item.service!.nameEn,
                                image:
                                    "${ApiUtl.main_image_url}${item.ownerImage}",
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProviderProfile(
                                      mainServiceId: widget.mainServiceId,
                                      isGolden: true,
                                      ownerId: item.id,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        ///::::::::::::: Owners List ::::::::::::::::
                        Container(
                          height: height * 0.15,
                          // height: height *
                          //         0.15 *
                          //         _ownersModel.owners!.length.toDouble() +
                          //     (_ownersModel.owners!.length.toDouble() * 10),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _ownersModel.owners?.length ?? 0,
                            itemBuilder: (context, index) {
                              var item = _ownersModel.owners![index];
                              return SingleProviderCard(
                                isGolden: false,
                                name: item!.ownerName,
                                image:
                                    "${ApiUtl.main_image_url}${item.ownerImage}",
                                serviceName: lang == "ar"
                                    ? "${item.service?.nameAr}"
                                    : "${item.service?.nameEn}",
                                rate: item.rate ?? 0,
                                city: lang == "ar"
                                    ? "${item.city?.nameAr}"
                                    : "${item.city?.nameEn}",
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProviderProfile(
                                      mainServiceId: widget.mainServiceId,
                                      isGolden: false,
                                      ownerId: item.id,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is OwnersErrorState) {
                return Text(state.error);
              }
              return Text("no data");
            },
          ),
        ),
      ),
    );
  }
}
