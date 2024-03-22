import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/privacy_and_policy_screen/models/privacy_and_policy_model.dart';

/// A controller class for the PrivacyAndPolicyScreen.
///
/// This class manages the state of the PrivacyAndPolicyScreen, including the
/// current privacyAndPolicyModelObj
class PrivacyAndPolicyController extends GetxController {
  Rx<PrivacyAndPolicyModel> privacyAndPolicyModelObj =
      PrivacyAndPolicyModel().obs;
}
