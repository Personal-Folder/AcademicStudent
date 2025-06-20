import 'package:academic_student/core/providers/banner_cubit/cubit/banner_cubit.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/view/pages/home/widgets/carousal_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/colors.dart';

class HomeCarousal extends StatelessWidget {
  const HomeCarousal({
    super.key,
  });

  // int _current = 0;
  @override
  Widget build(BuildContext context) {
    final carousel.CarouselController controller =
        carousel.CarouselController();

    ValueNotifier<int> current = ValueNotifier(0);

    return SizedBox(
      // height: ResponsiveSizes().isMobile(context)
      //     ? displayWidth(context) * 0.65
      //     : displayWidth(context) * 0.3,
      height: 312,
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerLoaded) {
            return Column(
              children: [
                carousel.CarouselSlider(
                  carouselController: controller,
                  items: state.banners.map((item) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 4,
                                offset: Offset(0.5, 0),
                                color: Colors.grey,
                                spreadRadius: 1)
                          ]),
                      child: CarousalShimmer(
                        key: Key(item.id.toString()),
                        imageLg: item.urlLg ?? '',
                        imageSm: item.urlSm ?? '',
                      ),
                    );
                  }).toList(),
                  options: carousel.CarouselOptions(
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    // height: ResponsiveSizes().isMobile(context)
                    //     ? displayWidth(context) * 0.6
                    //     : displayWidth(context) * 0.3,
                    height: 300,
                    onPageChanged: (index, _) {
                      current.value = index;
                    },
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                ValueListenableBuilder(
                    valueListenable: current,
                    builder: (context, current, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: state.banners
                            .map(
                              (item) => InkWell(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  controller.animateToPage(
                                      state.banners.indexOf(item));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(
                                        current == state.banners.indexOf(item)
                                            ? 1
                                            : 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }),
              ],
            );
          }
          return carousel.CarouselSlider(
            carouselController: controller,
            items: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgq_FMAWlM-S7xoHx_y-Uieq8A7s-A9nbqB6rYdgcK0A&s',
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  return Shimmer.fromColors(
                    baseColor: white,
                    highlightColor: Colors.grey[300]!,
                    child: child,
                  );
                },
              ),
            ],
            options: carousel.CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              onPageChanged: (index, _) {
                current.value = index;
              },
            ),
          );
        },
      ),
    );
  }
}
