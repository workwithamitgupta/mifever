import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/question_one_screen/models/question_one_two_model.dart';

class QuestionOneController extends GetxController {
  TextEditingController nameController = TextEditingController();

  Rx<QuestionOneTwoModel> questionOneTwoModelObj = QuestionOneTwoModel().obs;

  var isButtonDisable = true.obs;
  var recordedFilePath = ''.obs;
  RxDouble progress = 0.0.obs;
  late Timer timer;
  RxBool isPlaying = false.obs;

  void startTimer() async {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPlaying.value) {
        if (progress.value < 1) {
          print(progress.value);
          progress.value = progress.value + 0.2;
        } else {
          isPlaying.value = false;
          progress.value = 0.0;
          timer.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
    nameController.dispose();
  }
}
