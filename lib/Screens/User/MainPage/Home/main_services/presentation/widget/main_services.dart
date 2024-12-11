import '../../../../../../../API/api_utility.dart';
import '../../data/cubit/our_services_cubit.dart';
import '../../../../../SingleSection/presentation/screen/View.dart';
import '../../../../../../Widgets/CenterLoading.dart';
import '../../../../../../Widgets/Custom_Section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OurServices extends StatefulWidget {
  @override
  State<OurServices> createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  final String lang = translator.activeLanguageCode;

  @override
  void initState() {
    context.read<OurServicesCubit>().getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<OurServicesCubit, OurServicesState>(
        builder: (context, state) {
      if (state is OurServicesLoading) {
        return CenterLoading();
      } else if (state is OurServicesSuccess) {
        final _servicesModel = state.ourServicesModel;
        return Container(
          height: screenHeight / 2.8,
          padding: EdgeInsets.only(bottom: 10),
          width: screenWidth,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _servicesModel.services!.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomSection(
                  title: lang == "ar"
                      ? "${_servicesModel.services![index]!.nameAr}"
                      : "${_servicesModel.services![index]!.nameEn}",

                  /// change the .jpg in the last path
                  image:
                      "${ApiUtl.main_image_url}${_servicesModel.services![index]!.image}.jpg",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SingleSection(
                        serviceName: lang == "ar"
                            ? "${_servicesModel.services![index]!.nameAr}"
                            : "${_servicesModel.services![index]!.nameEn}",
                        mainServiceId: _servicesModel.services![index]!.id,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else if (state is OurServicesError) {
        return Center(
          child: Text(state.error),
        );
      } else {
        return Container();
      }
    });
  }
}
