import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/help_and_support_screen/models/help_and_support_screen_model.dart';

class HelpAndSupportController extends GetxController {
  Rx<HelpAndSupportModel> privacyAndPolicyOneModelObj =
      HelpAndSupportModel().obs;

  Rx<String> radioGroup = "".obs;
}
