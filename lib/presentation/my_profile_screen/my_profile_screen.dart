// ignore_for_file: sdk_version_since, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/data/sevices/media_services/media_services.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_switch.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../travel_Plans/controllers/travel_plan_screen.dart';
import 'controller/my_profile_controller.dart';
import 'models/frame7_item_model.dart';
import 'models/my_profile_one_model.dart';
import 'widgets/frame7_item_widget.dart';

// ignore_for_file: must_be_immutable
class MyProfileScreen extends GetWidget<MyProfileController> {
  MyProfileScreen({Key? key}) : super(key: key);
  final controller = Get.put(MyProfileController(MyProfileOneModel().obs));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return isHome();
        },
        child: Scaffold(
          body: SizedBox(
            width: SizeUtils.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.v),
                child: Column(
                  children: [
                    _buildProfileImage(),
                    SizedBox(height: 8.v),
                    CustomElevatedButton(
                      height: 28.v,
                      width: 140.h,
                      text: "msg_35_profile_completed".tr,
                      buttonStyle: CustomButtonStyles.fillRedTL14,
                      buttonTextStyle: CustomTextStyles.labelMediumRedA200,
                    ),
                    SizedBox(height: 8.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.v),
                          child: Text(
                            PrefUtils.getUserName(),
                            //"lbl_john_smith_24".tr,
                            style: CustomTextStyles.titleLargeGray900,
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.planName.value.isNotEmpty,
                            child: CustomImageView(
                              imagePath: controller.planName.value ==
                                      PlanType.Platinum.name
                                  ? ImageConstant.imgPlatinum
                                  : ImageConstant.imgGroup26,
                              height: 30.adaptSize,
                              width: 30.adaptSize,
                              margin: EdgeInsets.only(left: 8.h),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.v),
                    _buildPlan(),
                    SizedBox(height: 28.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.proflieDetailScreen);
                        },
                        languageSquare: ImageConstant.imgUserAccountRedA200,
                        languages: "lbl_profile_details".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.to(() => TravelPlanScreen());
                          //Get.toNamed(AppRoutes.createTravelPlanScreen);
                        },
                        languageSquare: ImageConstant.imgAirplane,
                        languages: "msg__my_travel_plan_name".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    _buildFrame2(),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.langaugesScreen);
                        },
                        languageSquare: ImageConstant.imgLanguageSquare,
                        languages: "lbl_languages".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.helpAndSupportScreen);
                        },
                        languageSquare: ImageConstant.imgHelpCircleRedA200,
                        languages: "lbl_help_support".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.termsAndConditionsScreen);
                        },
                        languageSquare: ImageConstant.imgTask02RedA200,
                        languages: "msg_terms_conditions".tr,
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: _buildFrame(
                        onTap: () {
                          Get.toNamed(AppRoutes.privacyAndPolicyScreen);
                        },
                        languageSquare: ImageConstant.imgSecurityCheck,
                        languages: "lbl_privacy_policy".tr,
                      ),
                    ),
                    SizedBox(height: 30.v),
                    CustomElevatedButton(
                      height: 40.v,
                      text: "lbl_log_out".tr,
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      buttonStyle: CustomButtonStyles.fillRedTL4,
                      buttonTextStyle: theme.textTheme.titleSmall!,
                      onPressed: onTapLogout,
                    ),
                    SizedBox(height: 30.v),
                    Text(
                      "lbl_version_0_011".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "lbl_mifever".tr,
                      style: CustomTextStyles.bodySmall11,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPlan() {
    return SizedBox(
      height: 193.v,
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: 20.h,
            );
          },
          itemCount:
              controller.myProfileOneModelObj.value.frame7ItemList.value.length,
          itemBuilder: (context, index) {
            Frame7ItemModel model = controller
                .myProfileOneModelObj.value.frame7ItemList.value[index];
            return Frame7ItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProfileImage() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUserById(PrefUtils.getId()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel _user =
              UserModel.fromJson(data!.data() as Map<String, dynamic>);

          return SizedBox(
            height: 172.v,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 125.v,
                    width: double.maxFinite,
                    decoration: AppDecoration.gradientOnPrimaryToRedA,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Opacity(
                          opacity: 0.16,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgLayer21,
                            height: 105.v,
                            width: 375.h,
                            alignment: Alignment.center,
                          ),
                        ),
                        CustomImageView(
                          onTap: () {
                            Share.share('text');
                          },
                          imagePath: ImageConstant.imgSend,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(
                            top: 20.v,
                            right: 20.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    clipBehavior: Clip.none,
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusStyle.circleBorder67,
                    ),
                    child: Container(
                      height: 134.adaptSize,
                      width: 134.adaptSize,
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.h,
                        vertical: 2.v,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusStyle.circleBorder67,
                      ),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Container(
                          //     height: 130.adaptSize,
                          //     width: 130.adaptSize,
                          //     decoration: BoxDecoration(
                          //       color: appTheme.red50,
                          //       borderRadius: BorderRadius.circular(
                          //         65.h,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          CustomImageView(
                            imagePath: ImageConstant.imgSettings,
                            height: 58.v,
                            width: 38.h,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                              left: 1.h,
                              top: 6.v,
                            ),
                          ),
                          CustomImageView(
                            imagePath: _user.profileImage!.isNotEmpty
                                ? _user.profileImage
                                : _user.lifeAlbum![0],
                            //ImageConstant.imgEllipse1598120x120,
                            height: 120.adaptSize,
                            width: 120.adaptSize,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(
                              60.h,
                            ),
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.v),
                            child: CustomIconButton(
                              onTap: onProfileEdit,
                              height: 40.adaptSize,
                              width: 40.adaptSize,
                              padding: EdgeInsets.all(10.h),
                              decoration:
                                  IconButtonStyleHelper.outlinePrimaryTL20,
                              alignment: Alignment.bottomRight,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEdit02,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  /// Section Widget
  Widget _buildFrame2() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgNotification02,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_notifications".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          Spacer(),
          Obx(
            () => CustomSwitch(
              margin: EdgeInsets.symmetric(vertical: 2.v),
              value: controller.isSelectedSwitch.value,
              onChange: (value) {
                controller.isSelectedSwitch.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFrame(
      {required String languageSquare,
      required String languages,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(11.h),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: languageSquare,
              height: 20.adaptSize,
              width: 20.adaptSize,
              margin: EdgeInsets.only(top: 1.v),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                top: 1.v,
              ),
              child: Text(
                languages,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: appTheme.gray900,
                ),
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgArrowRightGray6000416x16,
              height: 16.adaptSize,
              width: 16.adaptSize,
              margin: EdgeInsets.only(
                top: 1.v,
                bottom: 3.v,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapLogout() {
    PrefUtils.clearPreferencesData();
    Get.offAllNamed(AppRoutes.signInScreen);
  }

  void onProfileEdit() async {
    String filePath = await MediaServices.pickImageFromGallery();
    if (filePath.isNotEmpty) {
      ProgressDialogUtils.showProgressDialog();
      String url = await FirebaseServices.uploadFile(
          filePath: filePath, contentType: '.jpg');
      UserModel user = UserModel(profileImage: url);
      await FirebaseServices.updateUser(user);
      ProgressDialogUtils.hideProgressDialog();
    }
  }
}
