import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_five_screen/models/question_five_model.dart';

/// A controller class for the QuestionFiveScreen.
///
/// This class manages the state of the QuestionFiveScreen, including the
/// current questionFiveModelObj
class QuestionFiveController extends GetxController {
  TextEditingController countryEditTextController = TextEditingController();

  TextEditingController cityEditTextController = TextEditingController();

  Rx<QuestionFiveModel> questionFiveModelObj = QuestionFiveModel().obs;

  RxBool isButtonDisable = RxBool(true);

  var locationControllerCity = <TextEditingController>[TextEditingController()];
  var locationControllerCountry = <TextEditingController>[
    TextEditingController()
  ];

  var locationLength = 1.obs;
  bool isMakeButtonDisable() {
    print(locationControllerCity
            .firstWhereOrNull((element) => element.text.isEmpty) !=
        null);
    if (countryEditTextController.text.trim().isEmpty ||
        cityEditTextController.text.trim().isEmpty ||
        locationControllerCity
                .firstWhereOrNull((element) => element.text.isEmpty) !=
            null ||
        locationControllerCountry
                .firstWhereOrNull((element) => element.text.isEmpty) !=
            null) {
      isButtonDisable.value = true;
      return true;
    }
    isButtonDisable.value = false;
    return false;
  }

  @override
  void onClose() {
    super.onClose();
    countryEditTextController.dispose();
    cityEditTextController.dispose();
  }
}
