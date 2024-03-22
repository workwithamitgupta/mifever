// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../../data/sevices/google_places_services.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/filter_bottomsheet_controller.dart';

class FilterBottomsheet extends StatelessWidget {
  FilterBottomsheet({Key? key}) : super();

  final controller = Get.put(FilterBottomSheetController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120.v),
      child: SingleChildScrollView(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: EdgeInsets.only(bottom: 74.v),
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 12.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 55.h,
                    child: Divider(
                      color: appTheme.gray200,
                    ),
                  ),
                ),
                SizedBox(height: 11.v),
                Text(
                  "lbl_filter".tr,
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 15.v),
                Text(
                  "lbl_location".tr,
                  style: theme.textTheme.titleSmall,
                ),
                //SizedBox(height: 13.v),
                // Text(
                //   "lbl_country".tr,
                //   style: CustomTextStyles.titleSmallGray60004,
                // ),
                SizedBox(height: 6.v),
                _buildCountryField(),
                // CustomDropDown(
                //   hintText: "lbl_select_country".tr,
                //   items: controller
                //       .activePlanModelObj.value.dropdownItemList.value,
                //   prefix: Container(
                //     margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                //     child: CustomImageView(
                //       imagePath: ImageConstant.imgLocation01RedA200,
                //       height: 20.adaptSize,
                //       width: 20.adaptSize,
                //     ),
                //   ),
                //   prefixConstraints: BoxConstraints(
                //     maxHeight: 44.v,
                //   ),
                //   onChanged: (value) {
                //     controller.onSelected(value);
                //   },
                // ),

                // SizedBox(height: 13.v),
                // Text(
                //   "lbl_city".tr,
                //   style: CustomTextStyles.titleSmallGray60004,
                // ),
                // SizedBox(height: 6.v),
                // CustomDropDown(
                //   hintText: "lbl_select_city".tr,
                //   items: controller
                //       .activePlanModelObj.value.dropdownItemList1.value,
                //   prefix: Container(
                //     margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
                //     child: CustomImageView(
                //       imagePath: ImageConstant.imgLocation01RedA200,
                //       height: 20.adaptSize,
                //       width: 20.adaptSize,
                //     ),
                //   ),
                //   prefixConstraints: BoxConstraints(
                //     maxHeight: 44.v,
                //   ),
                //   onChanged: (value) {
                //     controller.onSelected1(value);
                //   },
                // ),
                SizedBox(height: 23.v),
                Text(
                  "lbl_distance".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 8.v),
                SliderTheme(
                  data: SliderThemeData(
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: appTheme.redA200,
                      inactiveTrackColor: appTheme.red50,
                      thumbColor: theme.colorScheme.onPrimary.withOpacity(1),
                      thumbShape: RoundSliderThumbShape(),
                      valueIndicatorColor: appTheme.redA200,
                      valueIndicatorTextStyle: TextStyle(color: Colors.white)),
                  child: Obx(
                    () => Slider(
                      label: controller.distanceSliderValue.value
                              .round()
                              .toString() +
                          "Km",
                      value: controller.distanceSliderValue.value,
                      min: 0.0,
                      max: 200.0,
                      divisions: 200,
                      onChanged: (value) {
                        controller.distanceSliderValue.value = value;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 4.v),
                // Padding(
                //   padding: EdgeInsets.only(left: 67.h),
                //   child: Text(
                //     "lbl_15_km".tr,
                //     style: theme.textTheme.labelMedium,
                //   ),
                // ),
                //SizedBox(height: 25.v),
                Text(
                  "lbl_age".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 6.v),
                _buildAgeFilter(),
                SizedBox(height: 24.v),
                Text(
                  "lbl_interested_in".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 7.v),
                _buildInterestedInChipView(),
                SizedBox(height: 23.v),
                // _buildTravelPlanRow(),
                // SizedBox(height: 12.v),
                // _buildTripDetailsColumn(),
                SizedBox(height: 152.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: controller.onCancelAll,
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            color: appTheme.redA200,
                            fontSize: 16.fSize,
                          ),
                        )),
                    SizedBox(width: 50.v),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(157.v, 55.v)),
                      onPressed: controller.onApply,
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 16.fSize,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAgeFilter() {
    return SizedBox(
      height: 44.v,
      width: 335.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          SliderTheme(
            data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: appTheme.redA200,
                inactiveTrackColor: appTheme.red50,
                thumbColor: theme.colorScheme.onPrimary.withOpacity(1),
                thumbShape: RoundSliderThumbShape(),
                valueIndicatorColor: appTheme.redA200,
                valueIndicatorTextStyle: TextStyle(color: Colors.white)),
            child: Obx(
              () => RangeSlider(
                values: controller.ageRange.value,
                min: 0.0,
                max: 100.0,
                divisions: 100,
                labels: RangeLabels(
                  '${controller.ageRange.value.start.round()}',
                  '${controller.ageRange.value.end.round()}',
                ),
                onChanged: (value) {
                  controller.ageRange.value = value;
                },
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin: EdgeInsets.only(left: 23.h),
          //     padding: EdgeInsets.symmetric(horizontal: 5.h),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(top: 28.v),
          //           child: Text(
          //             "lbl_18".tr,
          //             style: theme.textTheme.labelMedium,
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(
          //             left: 67.h,
          //             top: 27.v,
          //           ),
          //           child: Text(
          //             "lbl_24".tr,
          //             style: theme.textTheme.labelMedium,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInterestedInChipView() {
    List interest = ['Male', 'Female', 'Other'];
    return Wrap(
      runSpacing: 6.v,
      spacing: 6.h,
      children: List<Widget>.generate(
        interest.length,
        (index) {
          return Obx(
            () => Theme(
              data: ThemeData(
                canvasColor: Colors.transparent,
              ),
              child: RawChip(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 8.v,
                ),
                showCheckmark: false,
                labelPadding: EdgeInsets.zero,
                label: Text(
                  interest[index],
                  style: TextStyle(
                    color: interest[index] == controller.selectedInterest.value
                        ? theme.colorScheme.primary
                        : appTheme.gray60004,
                    fontSize: 14.fSize,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: interest[index] == controller.selectedInterest.value,
                backgroundColor: Colors.transparent,
                selectedColor: appTheme.redA200,
                shape: interest[index] == controller.selectedInterest.value
                    ? RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      )
                    : RoundedRectangleBorder(
                        side: BorderSide(
                          color: appTheme.gray200,
                          width: 1.h,
                        ),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                onSelected: (value) {
                  controller.selectedInterest.value = interest[index];
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildTravelPlanRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "msg_your_travel_plan".tr,
          style: theme.textTheme.titleSmall,
        ),
        Text(
          "lbl_create_more".tr,
          style: CustomTextStyles.titleSmallRedA200,
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildTripDetailsColumn() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70.h,
                  margin: EdgeInsets.only(top: 1.v),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "lbl_us_trip".tr,
                        style: CustomTextStyles.titleSmallBold,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgCheckmarkCircle02,
                        height: 16.adaptSize,
                        width: 16.adaptSize,
                        margin: EdgeInsets.only(bottom: 3.v),
                      ),
                    ],
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgMoreVerticalGray900,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgCalendar03,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "msg_24_feb_2024_12".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLocation01RedA2001,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "lbl_new_york_usa".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCountryField() {
    return CustomTextFormField(
      readOnly: true,
      controller: controller.locationController,
      hintText: "msg_select_your_country".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLocation01,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      textInputType: TextInputType.name,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "msg_select_your_country".tr;
        }
        return null;
      },
      onTap: () async {
        await GooglePlacesApiServices.placeSelectAPI(
                Get.context!, controller.locationController.text)
            .then((value) {
          controller.locationController.text =
              value!.result.formattedAddress.toString();
          controller.locationLatLong.value = GeoPoint(
            value.result.geometry!.location.lat,
            value.result.geometry!.location.lng,
          );
        });
      },
    );
  }
}
