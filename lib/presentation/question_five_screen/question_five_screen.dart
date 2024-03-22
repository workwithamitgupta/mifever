import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import 'controller/question_five_controller.dart';

// ignore_for_file: must_be_immutable
class QuestionFiveScreen extends GetWidget<QuestionFiveController> {
  QuestionFiveScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 11.v,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 8.v,
                    width: 335.h,
                    decoration: BoxDecoration(
                      color: appTheme.red50,
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                      child: LinearProgressIndicator(
                        value: 0.71,
                        color: appTheme.redA200,
                        backgroundColor: appTheme.red50,
                      ),
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Text(
                    "msg_where_are_you_from".tr,
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 21.v),
                  Text(
                    "lbl_country".tr,
                    style: CustomTextStyles.titleSmallGray60002,
                  ),
                  SizedBox(height: 6.v),
                  _buildCountryEditText(),
                  SizedBox(height: 21.v),
                  Text(
                    "lbl_city".tr,
                    style: CustomTextStyles.titleSmallGray60002,
                  ),
                  SizedBox(height: 6.v),
                  _buildCityEditText(),
                  SizedBox(height: 51.v),
                  Text(
                    "msg_add_your_other_available".tr,
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 22.v),
                  Obx(
                    () => Wrap(
                      spacing: 12.v,
                      runSpacing: 10.v,
                      children: List.generate(
                          controller.locationLength.value,
                          (index) => index.isEqual(0)
                              ? Text('')
                              : _buildMadridEurope(
                                  text: controller
                                          .locationControllerCountry[index - 1]
                                          .text +
                                      ", " +
                                      controller
                                          .locationControllerCity[index - 1]
                                          .text,
                                  onCancel: () {
                                    controller.locationLength.value--;
                                    controller.locationControllerCity
                                        .removeAt(index - 1);
                                    controller.locationControllerCountry
                                        .removeAt(index - 1);
                                  })),
                    ),
                  ),
                  SizedBox(height: 6.v),
                  Obx(
                    () => Column(
                      children: List.generate(
                        controller.locationLength.value,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "lbl_country".tr,
                              style: CustomTextStyles.titleSmallGray60002,
                            ),
                            SizedBox(height: 6.v),
                            _buildCountryEditText2(
                                controller.locationControllerCountry[index]),
                            SizedBox(height: 21.v),
                            Text(
                              "lbl_city".tr,
                              style: CustomTextStyles.titleSmallGray60002,
                            ),
                            SizedBox(height: 6.v),
                            _buildCityEditText2(
                                controller.locationControllerCity[index]),
                            SizedBox(height: 21.v),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.v),
                  InkWell(
                    onTap: () {
                      controller.locationLength.value++;
                      controller.locationControllerCity
                          .add(TextEditingController());
                      controller.locationControllerCountry
                          .add(TextEditingController());
                      controller.isMakeButtonDisable();
                    },
                    child: Obx(
                      () => Text(
                        "lbl_add_more".tr,
                        style: controller.isButtonDisable.value
                            ? CustomTextStyles.titleMediumGray60004
                            : CustomTextStyles.titleMediumRedA200,
                      ),
                    ),
                  ),
                  SizedBox(height: 125.h),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: _buildContinueButton(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgElementsGray900,
        margin: EdgeInsets.fromLTRB(25.h, 21.v, 330.h, 22.v),
      ),
    );
  }

  Widget _buildMadridEurope(
      {required String text, required VoidCallback onCancel}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.v, vertical: 8.v),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: appTheme.redA200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 2.v),
          CustomImageView(
            onTap: onCancel,
            imagePath: ImageConstant.imgArrowrightPrimary,
            height: 16.adaptSize,
            width: 16.adaptSize,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCountryEditText() {
    return CustomTextFormField(
      controller: controller.countryEditTextController,
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
      onChanged: (val) {},
    );
  }

  /// Section Widget
  Widget _buildCityEditText() {
    return CustomTextFormField(
      controller: controller.cityEditTextController,
      hintText: "msg_select_your_city".tr,
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
      textInputType: TextInputType.name,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "msg_select_your_city".tr;
        }
        return null;
      },
      onChanged: (val) {
        controller.isMakeButtonDisable();
      },
    );
  }

  /// Section Widget
  Widget _buildCountryEditText2(TextEditingController textEditingController) {
    return CustomTextFormField(
      controller: textEditingController,
      hintText: "msg_select_your_country".tr,
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
      textInputType: TextInputType.name,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "msg_select_your_country".tr;
        }
        return null;
      },
      onChanged: (val) {
        controller.isMakeButtonDisable();
      },
    );
  }

  /// Section Widget
  Widget _buildCityEditText2(TextEditingController textEditingController) {
    return CustomTextFormField(
      controller: textEditingController,
      hintText: "msg_select_your_city".tr,
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
      textInputType: TextInputType.name,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "msg_select_your_city".tr;
        }
        return null;
      },
      onChanged: (val) {
        controller.isMakeButtonDisable();
      },
    );
  }

  /// Section Widget
  Widget _buildContinueButton() {
    return Obx(
      () => CustomElevatedButton(
        text: "lbl_continue".tr,
        margin: EdgeInsets.only(
          left: 20.h,
          right: 20.h,
          bottom: 36.v,
        ),
        rightIcon: Container(
          margin: EdgeInsets.only(left: 4.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowleft02sharp,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
        buttonStyle: controller.isButtonDisable.value
            ? CustomButtonStyles.fillGray
            : null,
        onPressed: controller.isButtonDisable.value ? null : _onTapContinue,
      ),
    );
  }

  _onTapContinue() {
    FocusScope.of(Get.context!).unfocus();
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      Get.toNamed(AppRoutes.questionSixScreen);
    }
  }
}
