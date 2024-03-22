import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/my_profile_screen/models/my_profile_model.dart';

import '../../../data/models/subscriptions/subscription_model.dart';
import '../../../data/sevices/firebase_services.dart';
import '../models/my_profile_one_model.dart';

/// A controller class for the MyProfileScreen.
///
/// This class manages the state of the MyProfileScreen, including the
/// current myProfileModelObj
class MyProfileController extends GetxController {
  Rx<MyProfileModel> myProfileModelObj = MyProfileModel().obs;
  MyProfileController(this.myProfileOneModelObj);

  Rx<MyProfileOneModel> myProfileOneModelObj;

  Rx<bool> isSelectedSwitch = false.obs;

  RxString planName = ''.obs;

  getSubscription() async {
    SubscriptionModel? subscriptionModel =
        await FirebaseServices.getSubscription();
    if (subscriptionModel != null) {
      planName.value = subscriptionModel.plan.id!.value;
      print('plan==>${planName.value}');
    }
  }
}
