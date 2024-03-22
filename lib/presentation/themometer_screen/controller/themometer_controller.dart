import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/themometer_screen/models/themometer_model.dart';

class ThemometerController extends GetxController {
  Rx<ThemometerModel> themometerModelObj = ThemometerModel().obs;

  Rx<List<DateTime?>> selectedDatesFromCalendar1 = Rx([]);
}
