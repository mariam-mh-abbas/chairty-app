import 'dart:io';

import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:charity_project/main.dart';

import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/sign_in_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class profile_page extends StatefulWidget {
  profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController username = TextEditingController();

  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

  bool isEditing = false;
  File? selectedImage;

  Future<void> pickImage() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedImage = File(result.files.single.path!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: BackgroundWrapper(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileUpdateFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Profile update failed'.tr()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is ProfileUpdateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Profile updated successfully'.tr()),
                            backgroundColor: Colors.green),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ShowProfileLoaded) {
                      final profile = state.profile;
                      if (username.text.isEmpty)
                        username.text = profile.name ?? '';
                      if (phoneNumber.text.isEmpty)
                        phoneNumber.text = profile.phone ?? '';
                      if (email.text.isEmpty) email.text = profile.email ?? '';

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppBar(
                            backgroundColor: AppColors.white,
                            elevation: 2,
                            shadowColor: AppColors.unselected,
                            title: Text(
                              'Profile'.tr(),
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          InkWell(
                            onTap: isEditing
                                ? () {
                                    pickImage();
                                  }
                                : null,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 72,
                                  backgroundImage: selectedImage != null
                                      ? FileImage(selectedImage!)
                                      : (profile.profileImage != null &&
                                              profile.profileImage!.isNotEmpty
                                          ? NetworkImage(profile.profileImage!)
                                          : const AssetImage(
                                                  'assets/images/profile.jpg')
                                              as ImageProvider),
                                ),
                                if (isEditing)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: const Icon(Icons.camera_alt_rounded,
                                        size: 50, color: AppColors.primary),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: _nameFormKey,
                            child: _buildTextField(
                              controller: username,
                              label: "User Name".tr(),
                              icon: Icons.account_circle_outlined,
                              enabled: isEditing,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your name'.tr();
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: phoneNumber,
                            label: "Phone Number".tr(),
                            icon: Icons.phone_outlined,
                            enabled: false,
                            // prefix: const Text('+963'),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: email,
                            label: "Email".tr(),
                            icon: Icons.email_outlined,
                            enabled: false,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/as.png",
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Your Balance:".tr(),
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${profile.balance.toString()}" + "  \$",
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: isEditing
                                    ? null
                                    : () {
                                        setState(() {
                                          isEditing = true;
                                        });
                                      },
                                child: Text('Modify'.tr()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isEditing
                                      ? AppColors.unselected
                                      : AppColors.primary,
                                  fixedSize: const Size(100, 40),
                                  foregroundColor: AppColors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: isEditing
                                    ? () {
                                        if (_nameFormKey.currentState!
                                            .validate()) {
                                          context.read<ProfileBloc>().add(
                                                UpdateProfileEvent(
                                                  name: username.text,
                                                  image: selectedImage,
                                                ),
                                              );
                                          // context.read<ProfileBloc>().add(
                                          //       ShowProfileEvent(),
                                          //     );
                                          setState(() {
                                            isEditing = false;
                                          });
                                        }
                                      }
                                    : null,
                                child: Text('Confirm'.tr()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isEditing
                                      ? AppColors.primary
                                      : AppColors.unselected,
                                  fixedSize: const Size(100, 40),
                                  foregroundColor: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (state is ShowProfileError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppBar(
                              backgroundColor: AppColors.white,
                              elevation: 2,
                              shadowColor: AppColors.unselected,
                              title: Text(
                                'Profile'.tr(),
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 240,
                            ),
                            Icon(Icons.lock_outline,
                                size: 75, color: AppColors.primary),
                            const SizedBox(height: 20),
                            Text(
                              "To show your profile".tr(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => sign_in_page()));
                              },
                              child: Text(
                                'Sign in'.tr(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondary),
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 20, right: 20),
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   sign_in_page()));
                            //     },
                            //     child: Text('Sign in'),
                            //     style: ElevatedButton.styleFrom(
                            //         backgroundColor: AppColors.primary,
                            //         fixedSize: Size(120, 40),
                            //         foregroundColor: AppColors.white),
                            //   ),
                            // ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => sign_in_page()));
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: AppColors.primary,
                            //     foregroundColor: AppColors.white,
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 24, vertical: 12),
                            //   ),
                            //   child: const Text("تسجيل الدخول"),
                            // ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    Widget? prefix,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        validator: validator,
        style: TextStyle(
          color: enabled ? AppColors.primary : AppColors.black,
          fontWeight: enabled ? FontWeight.w600 : FontWeight.normal,
        ),
        decoration: AppInputDecoration.defaultDecoration.copyWith(
          label: Text(label),
          prefixIcon: Icon(icon, color: AppColors.primary),
          prefix: prefix,
          prefixStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          fillColor: enabled ? AppColors.white : AppColors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}



                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20),
                      //   child: TextFormField(
                      //     controller: username,
                      //     keyboardType: TextInputType.number,
                      //     decoration: AppInputDecoration.defaultDecoration.copyWith(
                      //       label: Text(" User Name "),
                      //       prefixIcon: Icon(
                      //         Icons.account_circle_outlined,
                      //         color: AppColors.primary,
                      //       ),
                      //     ),
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'please enter your name';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20),
                      //   child: TextFormField(
                      //     controller: phoneNumber,
                      //     keyboardType: TextInputType.number,
                      //     decoration: AppInputDecoration.defaultDecoration.copyWith(
                      //         label: Text("Phone Number"),
                      //         prefixIcon: Icon(
                      //           Icons.phone_outlined,
                      //           color: AppColors.primary,
                      //         ),
                      //         prefix: Text('+963')),
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'please enter your phone Number';
                      //       } else if (value.length != 9) {
                      //         return 'it must be 9 numbers';
                      //       } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                      //         return 'Only digits are allowed';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20),
                      //   child: TextFormField(
                      //     controller: email,
                      //     keyboardType: TextInputType.number,
                      //     decoration: AppInputDecoration.defaultDecoration.copyWith(
                      //       label: Text(" Email "),
                      //       prefixIcon: Icon(
                      //         Icons.email_outlined,
                      //         color: AppColors.primary,
                      //       ),
                      //     ),
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'please enter your Password';
                      //       } else if (value.length < 8) {
                      //         return 'it must be more than 8 characters';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
  // @override
  // void initState() {
  //   super.initState();

  //   loadUserProfile();
  // }

  // void loadUserProfile() {
  //   setState(() {});
  // }

  // Future<void> pickImage() async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picked != null) {
  //     setState(() {
  //       pickedFile = File(picked.path);
  //     });
  //   }
  // }

  // void submitProfile() {
  //   print("Name: ${username.text}");
  //   print("Image: ${pickedFile?.path ?? "Not changed"}");

  //   setState(() {
  //     isEditing = false;
  //   });
  // }