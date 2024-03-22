import 'package:mifever/core/app_export.dart';

import '../../question_three_dialog/models/question_three_model.dart';

class QuestionThreeController extends GetxController {
  Rx<QuestionThreeModel> questionThreeOneModelObj = QuestionThreeModel().obs;
  Rx<DateTime> initialDateTime = DateTime.now().obs;
  var selectedDate = 'Select date'.obs;
}
