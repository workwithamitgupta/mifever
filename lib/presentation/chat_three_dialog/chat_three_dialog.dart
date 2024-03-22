// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

class ChatThreeDialog extends StatelessWidget {
  ChatThreeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusStyle.roundedBorder4,
      child: Container(
        width: 335.h,
        padding: EdgeInsets.all(24.h),
        decoration: AppDecoration.fillPrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconButton(
              height: 72.adaptSize,
              width: 72.adaptSize,
              padding: EdgeInsets.all(14.h),
              decoration: IconButtonStyleHelper.fillRed,
              alignment: Alignment.center,
              child: CustomImageView(
                imagePath: ImageConstant.imgAirplane02,
              ),
            ),
            SizedBox(height: 14.v),
            Align(
              alignment: Alignment.center,
              child: Text(
                "lbl_about_tokyo".tr,
                style: CustomTextStyles.titleMediumGray900ExtraBold,
              ),
            ),
            SizedBox(height: 16.v),
            Container(
              width: 262.h,
              margin: EdgeInsets.only(
                left: 6.h,
                right: 17.h,
              ),
              child: Text(
                "msg_lorem_ipsum_dolor9".tr,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            SizedBox(height: 7.v),
            Container(
              width: 262.h,
              margin: EdgeInsets.only(
                left: 6.h,
                right: 17.h,
              ),
              child: Text(
                "msg_lorem_ipsum_dolor11".tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            SizedBox(height: 7.v),
            Container(
              width: 262.h,
              margin: EdgeInsets.only(
                left: 6.h,
                right: 17.h,
              ),
              child: Text(
                "msg_lorem_ipsum_dolor11".tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            SizedBox(height: 7.v),
            Container(
              width: 262.h,
              margin: EdgeInsets.only(
                left: 6.h,
                right: 17.h,
              ),
              child: Text(
                "msg_lorem_ipsum_dolor11".tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            SizedBox(height: 8.v),
            Padding(
              padding: EdgeInsets.only(left: 6.h),
              child: Text(
                "msg_lorem_ipsum_dolor12".tr,
                style: theme.textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 14.v),
            CustomElevatedButton(
              text: "lbl_book_now".tr,
              onPressed: () {
                Get.back();
                Get.toNamed(
                  AppRoutes.flightRecommendationOneScreen,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
