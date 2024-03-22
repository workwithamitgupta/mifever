import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/validation_functions.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import 'controller/edit_personal_details_controller.dart';
import 'models/profliedetailseditpersonaldeta_item_model.dart';
import 'widgets/profliedetailseditpersonaldeta_item_widget.dart';

// ignore_for_file: must_be_immutable
class EditPersonalDetailsScreen
    extends GetWidget<EditPersonalDetailsController> {
  EditPersonalDetailsScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 24.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "lbl_name".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 7.v),
                    _buildName(),
                    SizedBox(height: 23.v),
                    Text(
                      "lbl_email".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 8.v),
                    _buildEmail(),
                    SizedBox(height: 24.v),
                    Text(
                      "lbl_birth_date".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 8.v),
                    _buildBirthDate(),
                    SizedBox(height: 23.v),
                    Text(
                      "lbl_gender".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 6.v),
                    _buildGender(),
                    SizedBox(height: 25.v),
                    Text(
                      "lbl_country".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 6.v),
                    _buildCountry(),
                    SizedBox(height: 25.v),
                    Text(
                      "lbl_city".tr,
                      style: CustomTextStyles.titleSmallGray60004,
                    ),
                    SizedBox(height: 6.v),
                    _buildCity(),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: _buildFrame(),
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
        text: "msg_edit_personal_details".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildName() {
    return CustomTextFormField(
      controller: controller.nameController,
      hintText: "lbl_name".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      contentPadding: EdgeInsets.all(12.h),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "err_msg_please_enter_valid_text".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildEmail() {
    return CustomTextFormField(
      controller: controller.emailController,
      hintText: "msg_enter_email_address".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      textInputType: TextInputType.emailAddress,
      contentPadding: EdgeInsets.all(12.h),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      validator: (value) {
        if (value == null || (!isValidEmail(value, isRequired: true))) {
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
      onChanged: (val) {
        //   if (controller.emailController.text.isEmpty ||
        //       controller.passwordController.text.isEmpty) {
        //     controller.isButtonDisable.value = true;
        //   } else {
        //     controller.isButtonDisable.value = false;
        //   }
      },
    );
  }

  /// Section Widget
  Widget _buildBirthDate() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 9.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 1.v,
              bottom: 2.v,
            ),
            child: Text(
              "lbl_20_oct_1999".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCalendar03,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGender() {
    return SizedBox(
      height: 20.h,
      child: Padding(
        padding: EdgeInsets.only(right: 75.h),
        child: Obx(
          () => ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                width: 12.v,
              );
            },
            itemCount: controller.proflieDetailsEditPersonalDetailsModelObj
                .value.profliedetailseditpersonaldetaItemList.value.length,
            itemBuilder: (context, index) {
              ProfliedetailseditpersonaldetaItemModel model = controller
                  .proflieDetailsEditPersonalDetailsModelObj
                  .value
                  .profliedetailseditpersonaldetaItemList
                  .value[index];
              return ProfliedetailseditpersonaldetaItemWidget(
                model,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCountry() {
    return CustomTextFormField(
      controller: controller.countryController,
      hintText: "lbl_country".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLocation01RedA200,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "msg_select_your_country".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildCity() {
    return CustomTextFormField(
      controller: controller.cityController,
      hintText: "lbl_city".tr,
      hintStyle: CustomTextStyles.bodySmall12,
      textInputAction: TextInputAction.done,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 12.v, 8.h, 12.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLocation01RedA200,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 44.v,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "msg_select_your_city".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Padding(
        padding: EdgeInsets.only(
          left: 20.h,
          right: 20.h,
          bottom: 16.v,
        ),
        child: CustomElevatedButton(
          text: "lbl_save".tr,
          onPressed: _onTapContinue,
        ));
  }

  void _onTapContinue() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      controller.onTapContinue();
    }
  }
}
