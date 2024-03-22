import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/presentation/fileter_bottomsheet/models/fileter_bottomsheet_model.dart';
import 'package:mifever/presentation/home_screen/controller/home_controller.dart';
import 'package:mifever/widgets/custom_bottom_bar.dart';

import '../../../data/models/filter/filter_model.dart';

class FilterBottomSheetController extends GetxController {
  TextEditingController locationController = TextEditingController();

  Rx<GeoPoint> locationLatLong = GeoPoint(0.0, 0.0).obs;

  RxDouble distanceSliderValue = 0.0.obs;

  Rx<RangeValues> ageRange = Rx(RangeValues(0.0, 0.0));

  RxString selectedInterest = 'Male'.obs;

  Rx<ActivePlanModel> activePlanModelObj = ActivePlanModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  SelectionPopupModel? selectedDropDownValue1;

  onSelected(dynamic value) {
    for (var element in activePlanModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    activePlanModelObj.value.dropdownItemList.refresh();
  }

  onSelected1(dynamic value) {
    for (var element in activePlanModelObj.value.dropdownItemList1.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    activePlanModelObj.value.dropdownItemList1.refresh();
  }

  onApply() async {
    ProgressDialogUtils.showProgressDialog();
    PreferenceFilter filter = PreferenceFilter(
      country: locationController.text,
      city: '',
      distance: distanceSliderValue.value,
      ageRangeStart: ageRange.value.start,
      ageRangeEnd: ageRange.value.end,
      interestedIn: selectedInterest.value,
      locationText: locationController.text,
      lat: locationLatLong.value.latitude,
      lng: locationLatLong.value.longitude,
    );

    PrefUtils.saveFilter(filter);

    final homeController = Get.find<HomeController>();

    homeController.getUsersFiltered(
      minAge: ageRange.value.start.round(),
      maxAge: ageRange.value.end.round(),
      maxDistance: distanceSliderValue.value,
      gender: selectedInterest.value,
      currentUserLocation: locationLatLong.value,
    );
    ProgressDialogUtils.hideProgressDialog();
    Get.offAll(() => CustomBottomBar());
  }

  onCancelAll() {
    distanceSliderValue.value = 10.0;
    selectedInterest.value = getOppositeGender(PrefUtils.getUserGender());
    ageRange.value = RangeValues(18.0, 40.0);
    locationLatLong.value = GeoPoint(20.4481338, 82.7462439);
    locationController.text = "Roman Catholic";
    ProgressDialogUtils.showProgressDialog();
    PreferenceFilter filter = PreferenceFilter(
      country: locationController.text,
      city: '',
      distance: distanceSliderValue.value,
      ageRangeStart: ageRange.value.start,
      ageRangeEnd: ageRange.value.end,
      interestedIn: selectedInterest.value,
      locationText: locationController.text,
      lat: locationLatLong.value.latitude,
      lng: locationLatLong.value.longitude,
    );

    PrefUtils.saveFilter(filter);

    final homeController = Get.find<HomeController>();

    homeController.getUsersFiltered(
      minAge: ageRange.value.start.round(),
      maxAge: ageRange.value.end.round(),
      maxDistance: distanceSliderValue.value,
      gender: selectedInterest.value,
      currentUserLocation: locationLatLong.value,
    );
    ProgressDialogUtils.hideProgressDialog();
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    PrefUtils.getFilter().then((filter) {
      if (filter != null) {
        distanceSliderValue.value = filter.distance;
        ageRange.value = RangeValues(filter.ageRangeStart, filter.ageRangeEnd);
        selectedInterest.value = filter.interestedIn;
        locationController.text = filter.locationText;
        locationLatLong.value = GeoPoint(filter.lat, filter.lng);
      } else {
        distanceSliderValue.value = 10.0;
        selectedInterest.value = getOppositeGender(PrefUtils.getUserGender());
        ageRange.value = RangeValues(18.0, 40.0);
        locationLatLong.value = GeoPoint(20.4481338, 82.7462439);
        locationController.text = "Roman Catholic";
      }
    });
  }

  String getOppositeGender(String gender) {
    if (gender == 'Male') {
      return 'Female';
    } else if (gender == 'Female') {
      return 'Male';
    } else {
      return 'Other';
    }
  }
}
