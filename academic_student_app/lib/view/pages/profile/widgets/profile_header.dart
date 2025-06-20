import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';

class ProfileHeader extends StatefulWidget {
  final String name;
  final String? avatar;
  const ProfileHeader({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: widget.avatar != null
                      ? kIsWeb
                          ? ImageNetwork(
                              image: widget.avatar!,
                              height: 75,
                              width: 75,
                              borderRadius: BorderRadius.circular(90),
                              fitWeb: BoxFitWeb.cover,
                            )
                          : Image.network(
                              widget.avatar!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                      : Image.asset(
                          'assets/images/unkown_profile_icon.png',
                          fit: BoxFit.contain,
                          height: 100,
                          width: 100,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            widget.name,
            textAlign: TextAlign.start,
            style: GoogleFonts.tajawal(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
