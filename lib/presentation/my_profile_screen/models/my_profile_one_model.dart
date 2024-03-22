import 'package:mifever/presentation/my_profile_screen/models/frame7_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [my_profile_one_page],
/// and is typically used to hold data that is passed between different parts of the application.
class MyProfileOneModel {
  Rx<List<Frame7ItemModel>> frame7ItemList = Rx([
    Frame7ItemModel(
        id: PlanType.Gold.name.obs,
        buyGoldPlanText: "Buy Gold Plan".obs,
        loremIpsumDolorText: "Lorem ipsum dolor sit amet consectetur. ".obs),
    Frame7ItemModel(
        id: PlanType.Platinum.name.obs,
        buyGoldPlanText: "Buy Platinum Plan".obs,
        loremIpsumDolorText: "Lorem ipsum dolor sit amet consectetur. ".obs)
  ]);
}
