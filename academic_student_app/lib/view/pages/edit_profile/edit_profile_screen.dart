import 'dart:typed_data';

import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/view/shared/widgets/app_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Uint8List? _pickedImageBytes;
  String? _fileName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit_profile".tr),
      ),
      body: Padding(
        padding: MediaQuery.of(context).size.shortestSide > 600
            ? const EdgeInsets.symmetric(horizontal: 300)
            : const EdgeInsets.all(8.0),
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        _pickedImageBytes != null
                            ? Image.memory(
                                _pickedImageBytes!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                state is UserLoaded
                                    ? state.user.avatar ?? ""
                                    : "",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/unkown_profile_icon.png',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5)),
                            child: state is UserLoading
                                ? const CircularProgressIndicator.adaptive()
                                : IconButton(
                                    onPressed: () async {
                                      FilePickerResult? avatarPicker =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                        allowMultiple: false,
                                        withData: true,
                                      );
                                      if (avatarPicker != null) {
                                        setState(() {
                                          _pickedImageBytes =
                                              avatarPicker.files.first.bytes;
                                          _fileName =
                                              avatarPicker.files.first.name;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                    )),
                          ),
                        )
                      ],
                    ),
                  ),
                  AppTextField(
                    controller: _firstNameController,
                    hintText: state is UserLoaded ? state.user.firstName : "",
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "First name is required";
                      }
                      return null;
                    },
                  ),
                  AppTextField(
                    controller: _lastNameController,
                    hintText: state is UserLoaded ? state.user.lastName : "",
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Last name is required";
                      }
                      return null;
                    },
                  ),
                  AppTextField(
                    controller: _emailController,
                    hintText: state is UserLoaded ? state.user.email : "",
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "email is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          bool isFormValid =
                              _formKey.currentState?.validate() ?? false;
                          if (!isFormValid) {
                            return;
                          }
                          context.read<UserBloc>().add(
                                UserUpdate(
                                  avatar: [_pickedImageBytes, _fileName],
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                ),
                              );
                        },
                        child: state is UserLoaded
                            ? Text("edit_profile".tr)
                            : const CircularProgressIndicator.adaptive()),
                  )
                ],
              ));
        }),
      ),
    );
  }
}
