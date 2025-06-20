import 'package:academic_student/core/providers/social_media_groups_cubit/cubit/social_media_groups_cubit.dart';
import 'package:academic_student/view/pages/home/widgets/whatsapp_group_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class WhatsappGroupsScreen extends StatefulWidget {
  const WhatsappGroupsScreen({super.key});

  @override
  State<WhatsappGroupsScreen> createState() => _WhatsappGroupsScreenState();
}

class _WhatsappGroupsScreenState extends State<WhatsappGroupsScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  @override
  void initState() {
    context.read<SocialMediaGroupsCubit>().getSocialMediaGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SocialMediaGroupsCubit, SocialMediaGroupsState>(
        listener: (context, state) {
          if (state is SocialMediaGroupsLoaded) {
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _visible = true;
              });
            });
          }
        },
        builder: (context, state) {
          if (state is SocialMediaGroupsLoading) {
            return const LoadingState();
          } else if (state is SocialMediaGroupsLoaded) {
            return ListView.builder(
                itemCount: state.socialMediaGroups.length,
                itemBuilder: (context, index) => AnimatedSlide(
                      offset: _visible ? Offset.zero : const Offset(-1, 0),
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      child: WhatsappWidget(
                        whatsappGroup: state.socialMediaGroups[index],
                      ),
                    ));
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
