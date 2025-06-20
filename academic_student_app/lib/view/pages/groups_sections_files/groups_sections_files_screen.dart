import 'package:academic_student/view/pages/courses/courses_screen.dart';
import 'package:academic_student/view/pages/sections_screen/sections_screen.dart';
import 'package:academic_student/view/pages/university_files_screen/university_files_screen.dart';
import 'package:academic_student/view/pages/whatsapp_groups_screen/whatsapp_groups_screen.dart';
import 'package:academic_student/view/shared/widgets/leading_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupsSectionsFilesScreen extends StatefulWidget {
  const GroupsSectionsFilesScreen({super.key});

  @override
  State<GroupsSectionsFilesScreen> createState() =>
      _GroupsSectionsFieldsScreenState();
}

class _GroupsSectionsFieldsScreenState
    extends State<GroupsSectionsFilesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: LeadingBackButton(
            screenContext: context,
          ),
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Tab(
                  child: SvgPicture.asset(
                    "assets/icons/whatsapp.svg",
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Tab(
                  icon: Icon(
                    Icons.document_scanner_rounded,
                    size: 50,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Tab(
                    icon: Icon(
                  Icons.workspace_premium,
                  size: 50,
                )),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    WhatsappGroupsScreen(),
                    UniversityFilesScreen(),
                    CoursesScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
