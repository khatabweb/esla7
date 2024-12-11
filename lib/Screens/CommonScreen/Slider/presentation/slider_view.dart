import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../data/cubit/slider_cubit.dart';
import 'widget/no_order_contaner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../API/api_utility.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/CenterMessage.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final AssetImage? sliderImgSrc;

  ImageSlider({this.sliderImgSrc});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int current = 0;

  @override
  void initState() {
    context.read<SliderCubit>().getSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        if (state is SliderLoading) {
          return CenterLoading();
        } else if (state is SliderSuccess) {
          final sliderModel = state.sliderModel;
          if (sliderModel.banners!.length == 0) {
            return NoOrdersContainer();
          } else {
            return CarouselSlider(
              items: sliderModel.banners!.map(
                (item) {
                  return Container(
                    width: width,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: "${ApiUtl.main_image_url}${item!.image}",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 0.9,
                autoPlay: true,
                height: MediaQuery.of(context).size.height / 4,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      current = index;
                    },
                  );
                },
              ),
            );
          }
        } else if (state is SliderError) {
          return CenterMessage(state.error);
        } else {
          return CenterMessage(
            "no offer found at the moment",
          );
        }
      },
    );
  }
}
