// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:academic_student/core/providers/course_material_cubit/cubit/course_material_cubit.dart';
import 'package:academic_student/core/providers/request_type_cubit/cubit/request_type_cubit.dart';
import 'package:academic_student/core/services/request_service.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/extensions/column_ext.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/shared/widgets/large_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide MaterialState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../../shared/widgets/custom_scaffold_widget.dart';
import '../widgets/request_button_field.dart';
import '../widgets/request_drop_down_button_field.dart';
import '../widgets/request_text_field.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final TextEditingController titleController = TextEditingController();
  String? requestType;
  String? sessionId;
  List<File> files = [];
  String deliveryDate = '';
  final TextEditingController noteController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    context.read<CourseMaterialCubit>().getCourseMaterials('');

    return CustomScaffold(
      title: 'online_request',
      backHome: true,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CourseMaterialCubit>().getCourseMaterials('');
          context.read<RequestTypeCubit>().getRequestTypes();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              RequestTextField(
                fieldTItle: 'title_field'.tr,
                controller: titleController,
                linesRange: const RangeValues(
                  1,
                  2,
                ),
              ),
              BlocBuilder<CourseMaterialCubit, CourseMaterialState>(
                builder: (context, state) {
                  if (state is CourseMaterialLoaded) {
                    return RequestDropDownField(
                      setValue: (String? value) {
                        sessionId = value;
                        return sessionId;
                      },
                      fieldTitle: 'material_field'.tr,
                      fieldHint: 'select_material_text'.tr,
                      items: state.courseMaterials
                          .map<DropdownMenuItem>(
                            (courseMaterial) => DropdownMenuItem(
                              value: courseMaterial.id.toString(),
                              child: Text('${courseMaterial.code} - ${courseMaterial.name}'),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return RequestDropDownField(
                    setValue: (String? value) {
                      requestType = value;
                      return requestType;
                    },
                    fieldTitle: 'material_field'.tr,
                    fieldHint: 'select_material_text'.tr,
                    items: const <DropdownMenuItem>[],
                  );
                },
              ),
              BlocBuilder<RequestTypeCubit, RequestTypeState>(
                builder: (context, state) {
                  if (state is RequestTypeLoaded) {
                    return RequestDropDownField(
                      setValue: (String? value) {
                        setState(() {
                          requestType = value;
                        });
                        return requestType;
                      },
                      fieldTitle: 'request_type_field'.tr,
                      fieldHint: 'select_type_text'.tr,
                      items: state.requestTypes
                          .map<DropdownMenuItem>(
                            (type) => DropdownMenuItem(
                              value: type.id.toString(),
                              child: Text(type.name),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return RequestDropDownField(
                    fieldTitle: 'request_type_field'.tr,
                    fieldHint: 'loading'.tr,
                    items: const [],
                    setValue: (String? string) {
                      return null;
                    },
                  );
                },
              ),
              RequestButtonField(
                fieldTitle: 'files_field'.tr,
                icon: Image.asset(
                  'assets/images/academic-student/pdf_word_icon.png',
                  height: 30,
                ),
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                  );
                  if (result != null) {
                    setState(() {
                      files += result.paths.map((path) {
                        File file = File(path!).renameSync(join(dirname(path), 'Attachment - ${files.length + 1}${extension(path)}'));
                        return file;
                      }).toList();
                    });
                  }
                },
              ),
              if (files.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: files
                          .map(
                            (file) => Container(
                              height: 37,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: primaryColor,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    basename(file.path),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        files.removeWhere((element) => element == file);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: red.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              if (requestType != '3')
                RequestButtonField(
                  fieldTitle: 'delivery_date_field'.tr,
                  icon: const Icon(
                    Icons.date_range,
                    color: primaryColor,
                  ),
                  data: deliveryDate,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                        DateTime.now().year + 10,
                      ),
                    ).then((value) => setState(() {
                          deliveryDate = DateFormat('yyyy-MM-dd').format(value!);
                        }));
                  },
                ),
              RequestTextField(
                fieldTItle: 'note_field'.tr,
                controller: noteController,
                linesRange: const RangeValues(1, 5),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : LargeButton(
                      title: 'submit_button'.tr,
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await RequestService()
                            .submitRequest(
                          title: titleController.text,
                          sessionId: sessionId.toString(),
                          typeId: requestType.toString(),
                          deliveryDate: deliveryDate,
                          studentAttachments: files,
                          studentNotes: noteController.text,
                        )
                            .then((result) {
                          if (result[0] == 'success') {
                            Navigator.of(context).pushReplacementNamed(homeScreenRoute, arguments: true);
                          }
                          if (result[0] == 'error') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'error Happened',
                                ),
                              ),
                            );
                          }
                        }).then((value) => setState(() => isLoading = false));
                      },
                     textStyle: textLargeButtonStyle,
                    ),
            ],
          )
              .applyPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
              )
              .marginSymmetric(
                vertical: 10,
              ),
        ),
      ),
    );
  }
}
