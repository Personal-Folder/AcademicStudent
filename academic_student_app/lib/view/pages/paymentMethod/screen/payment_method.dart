import 'package:academic_student/core/providers/payment_method_cubit/cubit/payment_method_cubit.dart';
import 'package:academic_student/core/services/payment_method_service.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/view/pages/paymentMethod/widgets/payment_method_widget.dart';
import 'package:academic_student/view/shared/widgets/custom_scaffold_widget.dart';
import 'package:academic_student/view/shared/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentMethodScreen extends StatefulWidget {
  final int sessionId;
  final int subscriptionTypeId;
  const PaymentMethodScreen({super.key, required this.sessionId, required this.subscriptionTypeId});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = "";
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'payment_method',
      backHome: false,
      pop: true,
      redirect: false,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PaymentMethodCubit>().getPaymentMethods();
        },
        child: Center(
          child: Container(
            width: websiteSize / 2,
            alignment: Alignment.topCenter,
            child: BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodLoaded) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      children: [
                        ...state.paymentMethods
                            .map(
                              (paymentMethod) => PaymentMethodWidget(
                                paymentMethod: paymentMethod,
                                selectedMethod: selectedMethod,
                                onChanged: (resultString) {
                                  setState(() {
                                    selectedMethod = resultString;
                                  });
                                },
                              ),
                            )
                            .toList(),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            LargeButton(
                              title: 'pay_button_label'.tr,
                              onPressed: () async {
                                if (selectedMethod.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await PaymentService()
                                      .getReDirectUrl(
                                    widget.sessionId,
                                    widget.subscriptionTypeId,
                                    selectedMethod,
                                  )
                                      .then((result) {
                                    result.fold(
                                      (listResult) async {
                                        if (listResult[0] == 'success') {
                                          if (!await launchUrl(
                                            Uri.parse(listResult[1]),
                                            mode: LaunchMode.externalApplication,
                                          ).then((value) {
                                            if (value) {
                                              Navigator.of(context).pop();
                                            }
                                            return value;
                                          })) {
                                            CustomDialogs().errorDialog(message: 'Couldn\'t Continue The Payment, Ciintact Us for more information');
                                          } else {}
                                        }
                                      },
                                      (stringResult) {
                                        CustomDialogs().errorDialog(message: stringResult);
                                      },
                                    );
                                  });
                                }
                              },
                              minWidth: 200,
                              textStyle: textLargeButtonStyle,
                            )
                          ],
                        ),
                      ],
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
        ),
      ),
    );
  }
}
