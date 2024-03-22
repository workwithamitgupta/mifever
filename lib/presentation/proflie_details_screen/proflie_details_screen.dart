import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/about_me_page/about_me_page.dart';
import 'package:mifever/presentation/my_album_page/my_album_page.dart';
import 'package:mifever/presentation/personal_info_page/personal_info_page.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';

import '../../core/utils/progress_dialog_utils.dart';
import '../../data/models/user/user_model.dart';
import '../../data/sevices/media_services/media_services.dart';
import 'controller/proflie_details_controller.dart';

// ignore_for_file: must_be_immutable
class ProflieDetailScreen extends GetWidget<ProflieDetailsController> {
  const ProflieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseServices.getUserById(PrefUtils.getId()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox.shrink();
                    }
                    var data = snapshot.data;
                    UserModel _user = UserModel.fromJson(
                        data!.data() as Map<String, dynamic>);

                    return Column(
                      children: [
                        SizedBox(height: 24.v),
                        _buildFrame(),
                        SizedBox(height: 24.v),
                        SizedBox(
                          height: 90.v,
                          width: 80.h,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CustomImageView(
                                imagePath: _user.profileImage!.isNotEmpty
                                    ? _user.profileImage
                                    : _user.lifeAlbum![0],
                                // ImageConstant.imgEllipse159880x80,
                                height: 80.adaptSize,
                                width: 80.adaptSize,
                                radius: BorderRadius.circular(
                                  40.h,
                                ),
                                alignment: Alignment.topCenter,
                              ),
                              CustomIconButton(
                                onTap: onProfileEdit,
                                height: 36.adaptSize,
                                width: 36.adaptSize,
                                padding: EdgeInsets.all(10.h),
                                decoration:
                                    IconButtonStyleHelper.outlinePrimaryTL20,
                                alignment: Alignment.bottomCenter,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgCamera01Primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Text(
                          "lbl_profile_photo".tr,
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                    );
                  }),
              SizedBox(height: 24.v),
              _buildTab(),
              Expanded(
                child: SizedBox(
                  height: 893.v,
                  child: TabBarView(
                    controller: controller.tabviewController,
                    children: [
                      MyAlbumPage(),
                      PersonalInfoPage(),
                      AboutMePage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "lbl_profile_details".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMoreVertical,
          margin: EdgeInsets.all(16.h),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.fillRed.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "msg_profile_progression".tr,
            style: theme.textTheme.labelMedium,
          ),
          SizedBox(height: 1.v),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 3.v,
                    bottom: 5.v,
                  ),
                  child: Container(
                    height: 8.v,
                    width: 278.h,
                    decoration: BoxDecoration(
                      color: appTheme.red100,
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                      child: LinearProgressIndicator(
                        value: 0.35,
                        color: appTheme.redA200,
                        backgroundColor: appTheme.red100,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text(
                  "lbl_35".tr,
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTab() {
    return Container(
      height: 36.v,
      width: 335.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray200,
            width: 1.h,
          ),
        ),
      ),
      child: TabBar(
        controller: controller.tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.redA200,
        labelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: appTheme.gray900,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: appTheme.redA200,
              width: 2.h,
            ),
          ),
        ),
        tabs: [
          Tab(
            child: Text(
              "lbl_my_album".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_personal_info".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_about_me".tr,
            ),
          ),
        ],
      ),
    );
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
