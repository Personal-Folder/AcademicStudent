import 'package:academic_student/core/providers/staff_bloc/staff_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class InstructorsScreen extends StatefulWidget {
  const InstructorsScreen({super.key});

  @override
  State<InstructorsScreen> createState() => _InstructorsScreenState();
}

class _InstructorsScreenState extends State<InstructorsScreen> {
  bool _visible = false;
  @override
  void initState() {
    context.read<StaffBloc>().add(InitializeStaff());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("instructors".tr),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<StaffBloc, StaffState>(listener: (context, state) {
        if (state is StaffLoaded) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _visible = true;
            });
          });
        }
      }, builder: (context, state) {
        if (state is StaffLoaded) {
          return ListView.builder(
              itemCount: state.instructors.length,
              itemBuilder: (context, index) => AnimatedSlide(
                    offset: _visible ? Offset.zero : const Offset(-1, 0),
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 40,
                          width: 40,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Image.network(
                            state.instructors[index].avatar ?? "",
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/unkown_profile_icon.png',
                            ),
                          ),
                        ),
                        title: Text(
                          state.instructors[index].name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ));
        } else {
          return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) => Row(
                    children: [
                      Shimmer.fromColors(
                        direction: ShimmerDirection.ttb,
                        baseColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303030)
                      : const Color(0xFFEFEFEF),
                        highlightColor:
                            const Color.fromARGB(255, 224, 223, 223),
                        child: const CircleAvatar(),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Shimmer.fromColors(
                        direction: ShimmerDirection.ttb,
                        baseColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303030)
                      : const Color(0xFFEFEFEF),
                        highlightColor:
                            const Color.fromARGB(255, 224, 223, 223),
                        child: Container(
                          height: 30,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
              itemCount: 10);
        }
      }),
    );
  }
}
