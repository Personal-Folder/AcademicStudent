import 'package:academic_student/core/providers/university_files/cubit/university_file_cubit.dart';
import 'package:academic_student/view/shared/widgets/univeristy_file_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class UniversityFilesScreen extends StatefulWidget {
  const UniversityFilesScreen({super.key});

  @override
  State<UniversityFilesScreen> createState() => _UniversityFilesScreenState();
}

class _UniversityFilesScreenState extends State<UniversityFilesScreen> {
  bool _visible = false;
  @override
  void initState() {
    context.read<UniversityFileCubit>().getUniversityFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UniversityFileCubit, UniversityFileState>(
        listener: (context, state) {
          if (state is UniversityFileLoaded) {
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _visible = true;
              });
            });
          }
        },
        builder: (context, state) {
          if (state is UniversityFileLoading) {
            return const LoadingState();
          } else if (state is UniversityFileLoaded) {
            return Stack(
              children: [
                ListView.builder(
                    itemCount: state.universityFiles.length,
                    itemBuilder: (context, index) => AnimatedSlide(
                          duration: Duration(milliseconds: 300 + (index * 100)),
                          offset: _visible ? Offset.zero : const Offset(-1, 0),
                          child: UniveristyFileWidget(
                            universityFile: state.universityFiles[index],
                          ),
                        )),
              ],
            );
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
