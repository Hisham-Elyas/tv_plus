import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/localization/constants.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../auth/login/ui/login_screen.dart';
import '../../auth/models/user_model.dart';
import '../../auth/repos/auth_repo.dart';
import 'settings_controller.dart';

class ProfileController extends GetxController {
  late UserModel userInf;

  late StatusRequest statusReq = StatusRequest.loading;
  final AuthRepoImpHttp authRepo = Get.find();

  @override
  void onInit() async {
    print("ProfileController  onInit()");
    await getUserInfo();
    super.onInit();
  }

  _getUserInfoFromServer() async {
    print("_getUserInfoFromServer()");
    try {
      statusReq = StatusRequest.loading;
      update();
      final result = await authRepo.getUserInfo();
      result.fold(
        (l) {
          statusReq = l;
          update();
        },
        (r) {
          userInf = r;
          statusReq = StatusRequest.success;
          update();
        },
      );
    } catch (e) {
      showCustomSnackBar(
        message: e.toString(),
        title: "",
        isError: true,
      );
    }
  }

  getUserInfo() async {
    final userdata = await SharedPrefHelper.getString('user_info');
    if (userdata.isEmpty) {
      statusReq = StatusRequest.loading;
      update();
      try {
        final result = await authRepo.getUserInfo();
        result.fold(
          (l) {
            debugPrint("userdata ==>  not fond");
            statusReq = l;
            update();
          },
          (r) {
            userInf = r;
            debugPrint("userdata ==>  ${r.toString()}");
            statusReq = StatusRequest.success;
            update();
          },
        );
      } catch (e) {
        statusReq = StatusRequest.serverFailure;
        update();
        showCustomSnackBar(
          message: e.toString(),
          title: "",
          isError: true,
        );
      }
    } else if (userdata.isNotEmpty) {
      userInf = UserModel.fromMap(jsonDecode(userdata));
      statusReq = StatusRequest.success;
      update();
    } else {
      Get.find<SettingsController>().authRepo.logeOut();
      Get.offAll(() => const LoginScreen());
    }
  }

  // Method to update the email
  Future<void> updateEmail({required String newEmail}) async {
    showOverlay(
      asyncFunction: () async {
        try {
          final isSuccess = await authRepo.updateEmail(newEmail: newEmail);

          if (isSuccess) {
            await _getUserInfoFromServer();
            Get.back();
          }
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

// Method to update the password
  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    showOverlay(
      asyncFunction: () async {
        try {
          final isSuccess = await authRepo.updatePassword(
            newPassword: newPassword,
          );

          if (isSuccess) {
            Get.back();
          }
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

// Method to update the User Info
  Future<void> updateUserInfo({required UserModel userModel}) async {
    showOverlay(
      asyncFunction: () async {
        try {
          final isSuccess = await authRepo.updateUserInfo(userModel: userModel);

          if (isSuccess) {
            Get.back();
            _getUserInfoFromServer();
          }
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  void showActionBottomSheet(String action) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: _buildBottomSheetContent(action),
      ),
      isScrollControlled: true, // Allows full-screen height usage if needed
    );
  }

  Widget _buildBottomSheetContent(String action) {
    switch (action) {
      case 'email':
        return _buildEmailUpdateSheet();
      case 'password':
        return _buildPasswordUpdateSheet();
      case 'userInfo':
        return _buildUserInfoUpdateSheet();
      default:
        return const SizedBox();
    }
  }

  Widget _buildEmailUpdateSheet() {
    TextEditingController emailController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          UpdateEmail.tr,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        AppTextFormField(
          controller: emailController,
          hintText: NewEmail.tr,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: const ButtonStyle(elevation: WidgetStatePropertyAll(5)),
          onPressed: () async {
            await updateEmail(newEmail: emailController.text);
            Get.back();
          },
          child: Text(UpdateEmail.tr),
        ),
      ],
    );
  }

  Widget _buildPasswordUpdateSheet() {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ChangePassword.tr,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // AppTextFormField(
        //   controller: oldPasswordController,
        //   hintText: OldPassword.tr,
        //   obscureText: true,
        // ),
        // const SizedBox(height: 10),
        AppTextFormField(
          controller: newPasswordController,
          hintText: NewPassword.tr,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: const ButtonStyle(elevation: WidgetStatePropertyAll(5)),
          onPressed: () async {
            await updatePassword(
              oldPassword: oldPasswordController.text,
              newPassword: newPasswordController.text,
            );
            Get.back();
          },
          child: Text(UpdatePassword.tr),
        ),
      ],
    );
  }

  Widget _buildUserInfoUpdateSheet() {
    TextEditingController userNameController =
        TextEditingController(text: userInf.userName);
    TextEditingController phoneController =
        TextEditingController(text: userInf.phone);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          UpdateProfileInfo.tr,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        AppTextFormField(
          controller: userNameController,
          hintText: Username.tr,
        ),
        const SizedBox(height: 10),
        AppTextFormField(
          controller: phoneController,
          hintText: Phone.tr,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: const ButtonStyle(elevation: WidgetStatePropertyAll(5)),
          onPressed: () async {
            await updateUserInfo(
              userModel: userInf.copyWith(
                userName: userNameController.text,
                phone: phoneController.text,
              ),
            );
            Get.back();
          },
          child: Text(UpdateInfo.tr),
        ),
      ],
    );
  }
}
