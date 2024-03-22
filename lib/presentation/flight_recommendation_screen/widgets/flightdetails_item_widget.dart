import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import '../controller/flight_recommendation_controller.dart';
import '../models/flightdetails_item_model.dart';

// ignore: must_be_immutable
class FlightdetailsItemWidget extends StatelessWidget {
  FlightdetailsItemWidget(
    this.flightdetailsItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  FlightdetailsItemModel flightdetailsItemModelObj;

  var controller = Get.find<FlightRecommendationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.outlineGray900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                height: 26.v,
                width: 49.h,
                text: "lbl_cgk".tr,
                buttonStyle: CustomButtonStyles.fillRedTL14,
                buttonTextStyle: CustomTextStyles.labelLargeGray60004,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 6.v,
                  bottom: 2.v,
                ),
                child: Obx(
                  () => Text(
                    flightdetailsItemModelObj.hrsStop!.value,
                    style: CustomTextStyles.labelLargeOnPrimary,
                  ),
                ),
              ),
              CustomElevatedButton(
                height: 26.v,
                width: 50.h,
                text: "lbl_hnd".tr,
                buttonStyle: CustomButtonStyles.fillRedTL14,
                buttonTextStyle: CustomTextStyles.labelLargeGray60004,
              ),
            ],
          ),
          SizedBox(height: 7.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  flightdetailsItemModelObj.departureTime!.value,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Container(
                height: 20.adaptSize,
                width: 20.adaptSize,
                padding: EdgeInsets.all(1.h),
                decoration: AppDecoration.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgUserGray6000416x17,
                  height: 16.v,
                  width: 17.h,
                  alignment: Alignment.center,
                ),
              ),
              Obx(
                () => Text(
                  flightdetailsItemModelObj.arrivalTime!.value,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 33.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 1.v),
                child: Obx(
                  () => Text(
                    flightdetailsItemModelObj.airline!.value,
                    style: CustomTextStyles.titleSmallBlack900,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  flightdetailsItemModelObj.price!.value,
                  style: CustomTextStyles.titleMediumRedA200ExtraBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
