import 'package:academic_student/core/providers/sections_cubit/cubit/sections_cubit.dart';
import 'package:academic_student/view/pages/majors/screen/majors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/section.dart';
import '../../../../utils/constants/colors.dart';

class SectionWidget extends StatelessWidget {
  final Section section;
  final bool? showButton;
  final bool? isLoading;
  const SectionWidget({
    super.key,
    this.showButton = true,
    this.isLoading = false,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MajorScreen(section: section))),
        leading: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
              color: getRandomColor(), borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            (section.title ?? "").trim()[0],
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          )),
        ),
        title: Text((section.title ?? "").trim()),
        trailing: showButton!
            ? isLoading!
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator.adaptive(),
                  )
                : IconButton(
                    onPressed: () {
                      context
                          .read<SectionsCubit>()
                          .toggleFavoriteSection(section);
                    },
                    icon: section.isFavorite!
                        ? const Icon(Icons.star_rounded)
                        : const Icon(Icons.star_border_rounded))
            : const SizedBox(),
      ),
    );
  }
}
