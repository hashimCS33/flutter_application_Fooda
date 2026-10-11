import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/profile_cubit.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/profile_states.dart';
import 'package:flutter_application_hungray/Features/auth/data/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_hungray/Features/auth/view/login_view.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_btn.dart';
import 'package:flutter_application_hungray/shared/custom_snack.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widgets/custom_user_text_filed.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  bool _editingVisa = false;

  void _fill(UserModel? user) {
    if (user == null) return;
    _name.text = user.name ?? '';
    _email.text = user.Email ?? '';
    _address.text = user.address ?? "55 Najfa, IRAQ";
    _visa.text = user.visa ?? '';
  }

  void pickImage() => context.read<ProfileCubit>().pickImage();

  void removeImage() => context.read<ProfileCubit>().removeImage(
    name: _name.text.trim(),
    email: _email.text.trim(),
    address: _address.text.trim(),
    visa: _visa.text.trim(),
  );

  void updateProfileData() => context.read<ProfileCubit>().updateProfile(
    name: _name.text.trim(),
    email: _email.text.trim(),
    address: _address.text.trim(),
    visa: _visa.text.trim(),
  );

  void logout() => context.read<ProfileCubit>().logout();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    _password.dispose();
    _visa.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen:
          (p, c) =>
              p.user != c.user ||
              c.message != null ||
              c.status == ProfileStatus.loggedOut,
      listener: (context, state) {
        if (state.status == ProfileStatus.loggedOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginView()),
            (_) => false,
          );
          return;
        }
        if (state.message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(CustomSnackBar(state.message!));
        }
        _fill(state.user);
      },
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    final isGuest = state.isGuest;
    final userModel = state.user;
    final SelectedImage = state.selectedImage;
    final isLoading = state.status == ProfileStatus.updating;
    if (!isGuest) {
      return RefreshIndicator(
        displacement: 60,
        color: Colors.white,
        backgroundColor: AppColors.primary,
        onRefresh: () async {
          await context.read<ProfileCubit>().refresh();
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(238, 255, 255, 255),

            //App bar with settings icon
            appBar: AppBar(
              toolbarHeight: 0.0,
              backgroundColor: Colors.white,
              elevation: 0.0,
              scrolledUnderElevation: 0.0,
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Skeletonizer(
                enabled: userModel == null,
                child: Column(
                  children: [
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/settings.svg',
                            height: 24,
                            width: 24,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    Gap(20),

                    // Profile picture //اكو مشكلة بعدين ارجع اله شوفه
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            4,
                          ), // الفراغ الابيض بين البوردر والصورة
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.shade300,
                              child:
                                  SelectedImage != null
                                      ? Image.file(
                                        File(SelectedImage),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                      : (userModel?.imageUrl != null &&
                                          userModel!.imageUrl!.isNotEmpty)
                                      ? Image.network(
                                        userModel.imageUrl!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        errorBuilder:
                                            (context, error, builder) => Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Colors.grey,
                                            ),
                                      )
                                      : Icon(
                                        Icons.person,
                                        size: 60,
                                        color: const Color.fromARGB(
                                          255,
                                          250,
                                          249,
                                          249,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Gap(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: pickImage,
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: const Text('upload image'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              8,
                              0,
                              250,
                            ),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        Gap(10),
                        ElevatedButton.icon(
                          onPressed: removeImage,
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: const Text('remove image'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(30),

                    // User information fields
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          CustomUserTextField(
                            controller: _name,
                            labelText: 'Name',
                            keyboardType: TextInputType.name,
                            hinttext: 'Enter your Name',
                          ),

                          Gap(10),
                          CustomUserTextField(
                            controller: _email,
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            hinttext: 'Enter your Email',
                          ),

                          Gap(10),
                          CustomUserTextField(
                            controller: _address,
                            labelText: 'Delivery address',
                            keyboardType: TextInputType.streetAddress,
                            hinttext: 'Enter your Delivery address',
                          ),
                        ],
                      ),
                    ),

                    Gap(20),
                    Divider(
                      color: const Color.fromARGB(255, 14, 13, 13),
                      thickness: 1,
                    ),
                    Gap(10),

                    _editingVisa
                        ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomUserTextField(
                                controller: _visa,
                                labelText: 'Visa card',
                                keyboardType: TextInputType.number,
                                hinttext: 'ADD VISA CARD',
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  () => setState(() => _editingVisa = false),
                              icon: Icon(
                                CupertinoIcons.check_mark_circled_solid,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        )
                        : Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () => setState(() => _editingVisa = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF161616),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  CustomText(
                                    text: 'VISA',
                                    fontweight: FontWeight.w800,
                                    fontsize: 18,
                                    color: Colors.white,
                                  ),
                                  Gap(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Debit card',
                                          fontweight: FontWeight.w600,
                                          fontsize: 15,
                                          color: Colors.white,
                                        ),
                                        Gap(4),
                                        CustomText(
                                          text:
                                              (userModel?.visa != null &&
                                                      userModel!
                                                          .visa!
                                                          .isNotEmpty)
                                                  ? '•••• •••• •••• ${userModel.visa!.length >= 4 ? userModel.visa!.substring(userModel.visa!.length - 4) : userModel.visa}'
                                                  : '•••• •••• •••• 2022',
                                          fontweight: FontWeight.w400,
                                          fontsize: 13,
                                          color: Colors.white70,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text: 'Default',
                                          fontweight: FontWeight.w600,
                                          fontsize: 12,
                                          color: Colors.black87,
                                        ),
                                        Gap(4),
                                        Icon(
                                          Icons.check_circle,
                                          size: 16,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    Gap(30),

                    Row(
                      children: [
                        // Edit profile button
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child:
                                isLoading
                                    ? Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: const Center(
                                        child: CupertinoActivityIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                    : ElevatedButton(
                                      onPressed: updateProfileData,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                          ),
                        ),

                        const Gap(12),

                        // Logout button
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: logout,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black87,
                                side: const BorderSide(color: Colors.black87),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (isGuest) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Geust Mode ',
                color: AppColors.primary,
                fontsize: 22,
                fontweight: FontWeight.bold,
              ),
              Gap(20),
              CustomAuthBtn(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => LoginView()),
                  );
                },
                text: 'to go Login',
                color: const Color.fromARGB(255, 250, 251, 251),
                backgroundColor: AppColors.primary,
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}
