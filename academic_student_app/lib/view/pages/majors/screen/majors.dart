
import 'package:academic_student/core/models/section.dart';
import 'package:academic_student/core/providers/major_cubit/cubit/major_cubit.dart';
import 'package:academic_student/view/pages/majors/widgets/major_widget.dart';
import 'package:academic_student/view/shared/widgets/leading_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MajorScreen extends StatefulWidget {
  final Section section;
  const MajorScreen({
    super.key,
    required this.section,
  });

  @override
  State<MajorScreen> createState() => _MajorScreenState();
}

class _MajorScreenState extends State<MajorScreen> {
  bool _visible = false;
  @override
  void initState() {
    context.read<MajorCubit>().getMajors(widget.section.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingBackButton(screenContext: context),
        title: Text(widget.section.title ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<MajorCubit, MajorState>(
          listener: (context, state) {
            if (state is MajorLoaded) {
              Future.delayed(
                  const Duration(milliseconds: 500),
                  () => setState(() {
                        _visible = true;
                      }));
            }
          },
          builder: (context, state) {
            if (state is MajorLoading) {
              return const LoadingState();
            } else if (state is MajorLoaded) {
              return ListView.builder(
                  itemCount: state.majors.length,
                  itemBuilder: (context, index) => AnimatedSlide(
                        offset: _visible ? Offset.zero : const Offset(-1, 0),
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        child: MajorWidget(
                          major: state.majors[index],
                          section: widget.section,
                        ),
                      ));
            }
            return const SizedBox();
          },
        ),
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
              height: 100,
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ttb,
                  baseColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303030)
                      : const Color(0xFFEFEFEF),
                  highlightColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF505050)
                          : const Color.fromARGB(255, 224, 223, 223),
                  child: Container(
                    width: double.infinity,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
            ));
  }
}
