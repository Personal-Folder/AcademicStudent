import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/models/section.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/routes/routes.dart';

class SectionHomeWidget extends StatelessWidget {
  final Section section;
  const SectionHomeWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed(
            "$majorsScreenRoute?sectionId=${section.id}",
            arguments: section.id);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 5),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.5, 0),
                        color: Colors.grey,
                        blurRadius: 2)
                  ]),
              child: Center(
                child: Text(
                  (section.title ?? "")[0],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 50,
              child: Text(
                section.title ?? "",
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
