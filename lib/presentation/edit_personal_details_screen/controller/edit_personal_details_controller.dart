import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// A controller class for the ProflieDetailsEditPersonalDetailsScreen.
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/edit_personal_details_screen/models/edit_personal_details_model.dart';

class EditPersonalDetailsController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  Rx<EditPersonalDetailsModel> proflieDetailsEditPersonalDetailsModelObj =
      EditPersonalDetailsModel().obs;

  var selectedGender = 'Male'.obs;

  var dob = 'Male'.obs;

  Rx<UserModel> user = UserModel().obs;
  void onTapContinue() async {
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      dob: dob.value,
      city: cityController.text.trim(),
      country: countryController.text.trim(),
      gender: selectedGender.value,
    );
    ProgressDialogUtils.showProgressDialog();
    await FirebaseServices.updateUser(userModel).then((value) {
      if (value) {
        Fluttertoast.showToast(msg: 'Success');
      }
    });
    ProgressDialogUtils.hideProgressDialog();
  }

  @override
  void onInit() {
    FirebaseServices.getCurrentUser().then((user) {
      if (user != null) {
        nameController.text = user.name ?? '';
        emailController.text = user.email ?? '';
        dob.value = user.dob ?? '';
        selectedGender.value = user.gender ?? '';
        cityController.text = user.city ?? '';
        countryController.text = user.country ?? '';
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    countryController.dispose();
    cityController.dispose();
  }
}
