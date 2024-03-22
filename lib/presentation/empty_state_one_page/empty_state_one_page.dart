// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/empty_state_one_controller.dart';
import 'models/empty_state_one_model.dart';

class EmptyStateOnePage extends StatelessWidget {
  EmptyStateOnePage({Key? key}) : super(key: key);

  EmptyStateOneController controller =
      Get.put(EmptyStateOneController(EmptyStateOneModel().obs));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.fillPrimary,
      child: Column(
        children: [
          SizedBox(height: 160.v),
          _buildKeepScrolling(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildKeepScrolling() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.h),
      child: Column(
        children: [
          Container(
            height: 120.adaptSize,
            width: 120.adaptSize,
            padding: EdgeInsets.all(28.h),
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder60,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgUserOnprimary,
              height: 64.adaptSize,
              width: 64.adaptSize,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 19.v),
          Text(
            "msg_you_haven_t_liked".tr,
            style: CustomTextStyles.titleMediumGray900,
          ),
          SizedBox(height: 9.v),
          Text(
            "msg_please_keep_scrolling".tr,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 14.v),
          CustomElevatedButton(
            text: "lbl_keep_scrolling2".tr,
          ),
        ],
      ),
    );
  }
}
