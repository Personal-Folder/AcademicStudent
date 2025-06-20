import 'package:academic_student/utils/constants/display_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class CarousalShimmer extends StatefulWidget {
  final String imageSm;
  final String imageLg;
  const CarousalShimmer(
      {super.key, required this.imageSm, required this.imageLg});

  @override
  State<CarousalShimmer> createState() => _CarousalShimmerState();
}

class _CarousalShimmerState extends State<CarousalShimmer> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? ImageNetwork(
            image: ResponsiveSizes().isMobile(context)
                ? widget.imageSm
                : widget.imageLg,
            height: ResponsiveSizes().isMobile(context)
                ? displayWidth(context) * 0.6
                : displayWidth(context) * 0.3,
            width: displayWidth(context),
            fitWeb: BoxFitWeb.cover,
            borderRadius: BorderRadius.circular(20),
            fitAndroidIos: BoxFit.cover,
            imageCache: NetworkImage(
              ResponsiveSizes().isMobile(context)
                  ? widget.imageSm
                  : widget.imageLg,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              ResponsiveSizes().isMobile(context)
                  ? widget.imageSm
                  : widget.imageLg,
              height: ResponsiveSizes().isMobile(context)
                  ? displayWidth(context) * 0.6
                  : displayWidth(context) * 0.3,
              width: displayWidth(context),
              fit: BoxFit.fill,
              // cacheHeight: ResponsiveSizes().isMobile(context) ? (displayWidth(context) * 0.6).toInt() : (displayWidth(context) * 0.3).toInt(),
              // cacheWidth: displayWidth(context).toInt(),
            ),
          );
  }
}
