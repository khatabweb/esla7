import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../API/api_utility.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/CenterMessage.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_Background.dart';
import '../../../ProviderProfile/OwnerDetails/presentation/screen/ProviderProfile.dart';
import '../../data/advertiser_cubit/advertisers_cubit.dart';
import '../../data/owner_bloc/cubit.dart';
import '../../data/owner_bloc/model.dart';
import '../../data/owner_bloc/state.dart';
import '../widgets/SingleProviderCard.dart';

class SingleSection extends StatefulWidget {
  final String? serviceName;
  final int? mainServiceId;
  const SingleSection({Key? key, this.mainServiceId, this.serviceName})
      : super(key: key);

  @override
  State<SingleSection> createState() => _SingleSectionState();
}

class _SingleSectionState extends State<SingleSection> {
  // final String lang = translator.activeLanguageCode;

  @override
  void initState() {
    context.read<AdvertisersCubit>().getAdvertisers();
    context.read<OwnersCubit>().getOwners(widget.mainServiceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "${widget.serviceName}",
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      body: CustomBackground(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: AnimatedWidgets(
            verticalOffset: 50,
            child: Column(
              children: [
                ///::::::::::::: Advertiser List ::::::::::::::::
                BlocBuilder<AdvertisersCubit, AdvertisersState>(
                  builder: (context, state) {
                    if (state is AdvertisersLoading) {
                      return CenterLoading();
                    } else if (state is AdvertisersSuccess) {
                      final _advertisersModel = state.advertisersModel;
                      if (_advertisersModel.advertisers!.length == 0) {
                        return SizedBox.shrink();
                      } else {
                        return Container(
                          // color: Colors.yellowAccent,
                          // height: height * 0.5,
                          height: height *
                                  0.15 *
                                  _advertisersModel.advertisers!.length
                                      .toDouble() +
                              (_advertisersModel.advertisers!.length
                                      .toDouble() *
                                  10),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _advertisersModel.advertisers!.length,
                            itemBuilder: (context, index) {
                              var item =
                                  _advertisersModel.advertisers![index];
                              return SingleProviderCard(
                                isGolden: true,
                                name: item!.ownerName,
                                city: context.locale.languageCode == "ar"
                                    ? item.city!.nameAr
                                    : item.city!.nameEn,
                                rate: item.rate ?? 0,
                                serviceName: context.locale.languageCode == "ar"
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
                        );
                      }
                    } else if (state is AdvertisersError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  },
                ),
    
                ///::::::::::::: Owners List ::::::::::::::::
                BlocBuilder<OwnersCubit, OwnersState>(
                  builder: (context, state) {
                    if (state is OwnersLoadingState) {
                      return CenterLoading();
                    } else if (state is OwnersSuccessState) {
                      final _ownersModel = state.ownersModel;
                      if (_ownersModel.owners!.length == 0) {
                        return CenterMessage("no_owners".tr());
                      } else {
                        late List<OwnerModelOwners?>? item = [];
                        for (var i = 0;
                            i < _ownersModel.owners!.length;
                            i++) {
                          if (widget.serviceName ==
                                  _ownersModel.owners![i]!.service!.nameEn ||
                              widget.serviceName ==
                                  _ownersModel.owners![i]!.service!.nameAr) {
                            item.add(_ownersModel.owners![i]);
                          }
                          // item.add(_ownersModel.owners![i]);
                        }
                        return Container(
                          height: height * 0.15 * item.length.toDouble() +
                              (item.length.toDouble() * 10),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return SingleProviderCard(
                                isGolden: false,
                                name: item[index]!.ownerName,
                                image:
                                    "${ApiUtl.main_image_url}${item[index]!.ownerImage}",
                                serviceName: context.locale.languageCode == "ar"
                                    ? "${item[index]!.service?.nameAr}"
                                    : "${item[index]!.service?.nameEn}",
                                rate: item[index]!.rate ?? 0,
                                city: context.locale.languageCode == "ar"
                                    ? "${item[index]!.city?.nameAr}"
                                    : "${item[index]!.city?.nameEn}",
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProviderProfile(
                                      mainServiceId: widget.mainServiceId,
                                      isGolden: false,
                                      ownerId: item[index]!.id,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } else if (state is OwnersErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
