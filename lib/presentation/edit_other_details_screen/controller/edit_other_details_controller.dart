import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/presentation/edit_other_details_screen/models/edit_other_details_model.dart';

import '../../../data/sevices/firebase_services.dart';

class EditOtherDetailsController extends GetxController {
  TextEditingController cityController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  Rx<EditOtherDetailsModel> editOtherDetailsModelObj =
      EditOtherDetailsModel().obs;

  var locationControllerCityControllerList = <TextEditingController>[].obs;
  var locationControllerCountryControllerList = <TextEditingController>[].obs;

  Rx<String> whatDoYouWantToFindOut = "lbl_casual_dating".tr.obs;

  List selectedInterest = [].obs;

  var isButtonDisable = false.obs;

  List palyList = [
    'Movie',
    'Gaming',
    'Nature',
    'Photography',
    'Gym & Fitness',
    'Sports',
    'Design',
    'Dancing',
    'Reading',
    'Music',
    'Writing',
    'Cooking',
    'Animals',
  ];

  void onTapSave() async {
    ProgressDialogUtils.showProgressDialog();
    UserModel _userModel = UserModel(
      interestList: selectedInterest,
      whatDoYouWant: whatDoYouWantToFindOut.value,
      availableCity: getCity(),
      availableCountry: getCountry(),
    );
    await FirebaseServices.updateUser(_userModel);
    ProgressDialogUtils.hideProgressDialog();
  }

  List getCity() {
    List _city = [];

    for (var city in locationControllerCityControllerList) {
      _city.add(city.text);
    }
    return _city;
  }

  List getCountry() {
    List _country = [];

    for (var country in locationControllerCountryControllerList) {
      _country.add(country.text);
    }
    return _country;
  }

  @override
  void onInit() {
    FirebaseServices.getCurrentUser().then((user) {
      if (user != null) {
        selectedInterest.clear();
        selectedInterest.addAll(user.interestList ?? []);
        whatDoYouWantToFindOut.value = user.whatDoYouWant ?? '';

        for (var i = 0; i < user.availableCity!.length; i++) {
          locationControllerCityControllerList.add(TextEditingController());
          locationControllerCountryControllerList.add(TextEditingController());
          locationControllerCityControllerList[i].text =
              user.availableCity?[i] ?? '';
          locationControllerCountryControllerList[i].text =
              user.availableCountry?[i] ?? '';
        }
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    cityController.dispose();
    countryController.dispose();
  }
}
