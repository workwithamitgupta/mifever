// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';

import '../../data/models/user/user_model.dart';
import 'controller/personal_info_controller.dart';
import 'models/personal_info_model.dart';
import 'models/your_interest_model.dart';
import 'widgets/available_location_widget.dart';
import 'widgets/your_interest_chip_widget.dart';

class PersonalInfoPage extends StatelessWidget {
  PersonalInfoPage({Key? key}) : super(key: key);

  PersonalInfoController controller =
      Get.put(PersonalInfoController(PersonalInfoModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.h,
                    right: 17.h,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: _buildFrameTitle(
                            otherDetails: "msg_personal_details".tr,
                            onTap: () {
                              Get.toNamed(AppRoutes.editPersonalDetailsScreen);
                            }),
                      ),
                      SizedBox(height: 16.v),
                      _buildPersonalDetail(),
                      SizedBox(height: 25.v),
                      Padding(
                        padding: EdgeInsets.only(right: 3.h),
                        child: _buildFrameTitle(
                          otherDetails: "lbl_other_details".tr,
                          onTap: () {
                            Get.toNamed(AppRoutes.editOtherDetailsScreen);
                          },
                        ),
                      ),
                      SizedBox(height: 16.v),
                      _buildOtherDetails(),
                      SizedBox(height: 24.v),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPersonalDetail() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user = UserModel();
          _user = UserModel.fromJson(data?.data() as Map<String, dynamic>);
          return Container(
            width: 335.h,
            margin: EdgeInsets.only(left: 3.h),
            padding: EdgeInsets.all(14.h),
            decoration: AppDecoration.outlineGray200.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 2.v),
                Text(
                  "lbl_name".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  _user.name.toString().capitalize ?? '',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 17.v),
                Text(
                  "lbl_email".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 5.v),
                Text(
                  _user.email ?? '',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 15.v),
                Text(
                  "lbl_birth_date".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  _user.dob ?? '',
                  // "lbl_20_oct_1999".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 17.v),
                Text(
                  "lbl_gender".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  _user.gender ?? '',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 18.v),
                Text(
                  "lbl_country".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 3.v),
                Text(
                  "${_user.city},${_user.country}",
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          );
        });
  }

  /// Section Widget
  Widget _buildOtherDetails() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user = UserModel();
          _user = UserModel.fromJson(data?.data() as Map<String, dynamic>);
          return Container(
            width: 335.h,
            margin: EdgeInsets.only(right: 3.h),
            padding: EdgeInsets.all(15.h),
            decoration: AppDecoration.outlineGray200.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "lbl_your_interest".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 9.v),
                Obx(
                  () => Wrap(
                    runSpacing: 12.v,
                    spacing: 12.h,
                    children: List<Widget>.generate(
                      _user.interestList?.length ?? 0,
                      (index) {
                        YourInterestModel model = controller
                            .proflieDetailsPersonalInfoModelObj
                            .value
                            .yourInterestList
                            .value[index];

                        return YourInterestChipWidget(
                          text: _user.interestList?[index] ?? '',
                          yourInterestModel: model,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 17.v),
                Text(
                  "lbl_you_re_here_for".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 5.v),
                Text(
                  _user.whatDoYouWant ?? '',
                  // "msg_serious_relationship2".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 15.v),
                Text(
                  "msg_available_locations".tr,
                  style: CustomTextStyles.labelLargeGray60004,
                ),
                SizedBox(height: 7.v),
                Wrap(
                  runSpacing: 12.v,
                  spacing: 12.h,
                  children: List<Widget>.generate(
                    _user.availableCity?.length ?? 0,
                    (index) {
                      return AvailableLocationWidget(
                          "${_user.availableCity?[index]},${_user.availableCountry?[index]}");
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  /// Common widget
  Widget _buildFrameTitle(
      {required String otherDetails, required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          otherDetails,
          style: CustomTextStyles.titleMediumGray900ExtraBold.copyWith(
            color: appTheme.gray900,
          ),
        ),
        CustomImageView(
          onTap: onTap,
          imagePath: ImageConstant.imgEdit02RedA200,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ],
    );
  }
}
