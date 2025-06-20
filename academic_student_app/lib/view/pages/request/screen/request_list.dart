import 'package:academic_student/core/providers/request_cubit/cubit/request_cubit.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/shared/widgets/custom_scaffold_widget.dart';
import 'package:academic_student/view/shared/widgets/large_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RequestCubit>().getUserRequests();

    return CustomScaffold(
      title: 'request_list',
      backHome: true,
      arguments: true,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<RequestCubit>().getUserRequests();
        },
        child: BlocBuilder<RequestCubit, RequestState>(
          builder: (context, state) {
            if (state is RequestLoaded) {
              return ListView.builder(
                itemCount: state.requests.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      Flexible(
                        child: Center(
                          child: Column(
                            textDirection: TextDirection.ltr,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  state.requests[index].title,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  'Math300',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 18,
                                    color: grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Divider(
                          color: grey,
                          thickness: 2,
                        ),
                      ),
                      Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        textDirection: TextDirection.rtl,
                        children: [
                          TableRow(
                            children: [
                              const Icon(
                                Icons.date_range,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                state.requests[index].deliveryDate,
                                textAlign: TextAlign.start,
                                style: textRequestListStyle,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Icon(
                                Icons.file_copy,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                state.requests[index].type.name,
                                textAlign: TextAlign.start,
                                style: textRequestListStyle,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const CircleAvatar(
                                backgroundColor: red,
                                radius: 7,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                state.requests[index].status.name,
                                textAlign: TextAlign.start,
                                style: textRequestListStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: LargeButton(
                          title: 'check',
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              requestDetailScreenRoute,
                              arguments: state.requests[index],
                            );
                          },
                          textStyle: textLargeButtonStyle,
                          maxHeight: 30,
                          minWidth: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
