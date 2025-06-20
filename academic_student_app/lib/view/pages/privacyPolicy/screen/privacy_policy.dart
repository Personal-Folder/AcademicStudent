import 'package:academic_student/view/pages/home/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/providers/legal_agreements_cubit/cubit/legal_agreement_cubit.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LegalAgreementCubit>().getAllLegalAgreements(
      [
        'privacy_policy',
      ],
    );
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const HomeScreen(refresh: false)),
            (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: BlocBuilder<LegalAgreementCubit, LegalAgreementState>(
              builder: (context, state) {
                if (state is LegalAgreementLoaded) {
                  return Text(
                    state.legalAgreements
                        .where((map) => map.containsKey("privacy_policy"))
                        .firstWhere((map) => true)['privacy_policy']!
                        .body,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const LoadingState(),
                );
              },
            ),
          ),
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
        itemCount: 3,
        itemBuilder: (context, index) =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    width: 100,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 16,
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
                    width: 200,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 8,
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
                    width: 200,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 8,
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
                    width: 250,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 8,
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
                    width: 300,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 8,
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
                    width: 350,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 8,
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
                    width: 200,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 8,
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
                    width: 200,
                    height: 15,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 8,
              ),
            ]));
  }
}
