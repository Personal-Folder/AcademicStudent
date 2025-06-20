import 'package:academic_student/core/providers/sections_cubit/cubit/sections_cubit.dart';
import 'package:academic_student/view/pages/sections/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  bool _visible = false;
  @override
  void initState() {
    context.read<SectionsCubit>().getSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SectionsCubit, SectionsState>(
        listener: (context, state) {
          if (state is SectionsLoaded) {
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _visible = true;
              });
            });
          }
        },
        builder: (context, state) {
          if (state is SectionsLoading) {
            return const LoadingState();
          } else if (state is SectionLoading) {
            return ListView.builder(
                itemCount: state.sections.length,
                itemBuilder: (context, index) => AnimatedSlide(
                    offset: _visible ? Offset.zero : const Offset(-1, 0),
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    child: SectionWidget(
                      section: state.sections[index],
                      isLoading: state.sections[index] == state.section,
                    )));
          } else if (state is SectionsLoaded) {
            return ListView.builder(
                itemCount: state.sections.length,
                itemBuilder: (context, index) => AnimatedSlide(
                    offset: _visible ? Offset.zero : const Offset(-1, 0),
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    child: SectionWidget(section: state.sections[index])));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                      direction: ShimmerDirection.ttb,
                      baseColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303030)
                      : const Color(0xFFEFEFEF),
                      highlightColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF505050)
                          : const Color.fromARGB(255, 224, 223, 223),
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Shimmer.fromColors(
                      direction: ShimmerDirection.ttb,
                      baseColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303030)
                      : const Color(0xFFEFEFEF),
                      highlightColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF505050)
                          : const Color.fromARGB(255, 224, 223, 223),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 15,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ));
  }
}
