import 'package:academic_student/core/providers/session_material_cubit/cubit/session_material_cubit.dart';
import 'package:academic_student/view/pages/sessionMaterialDetail/screen/session_material_detail.dart';
import 'package:academic_student/view/shared/widgets/no_data_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SessionMaterialsScreen extends StatefulWidget {
  final int courseMaterialId;
  final int sectionId;
  final int majorId;
  const SessionMaterialsScreen({
    super.key,
    required this.courseMaterialId,
    required this.sectionId,
    required this.majorId,
  });

  @override
  State<SessionMaterialsScreen> createState() => _SessionMaterialsScreenState();
}

class _SessionMaterialsScreenState extends State<SessionMaterialsScreen> {
  @override
  void initState() {
    context
        .read<SessionMaterialCubit>()
        .getSessionMaterials(widget.courseMaterialId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SessionMaterialCubit, SessionMaterialState>(
          builder: (context, state) {
            if (state is SessionMaterialLoading) {
              return const LoadingState();
            } else if (state is SessionMaterialLoaded) {
              if (state.sessionMaterials.isEmpty) {
                return const NoListDataWidget();
              }
              return ListView.builder(
                itemCount: state.sessionMaterials.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/unkown_profile_icon.png"),
                    ),
                    title: Text(state.sessionMaterials[index].name),
                    trailing: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SessionMaterialDetail(
                                    sessionMaterialId:
                                        state.sessionMaterials[index].id,
                                  ))),
                      child: Text("join".tr),
                    ),
                  ),
                ),
              );
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
