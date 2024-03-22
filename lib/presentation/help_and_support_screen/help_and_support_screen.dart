import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';

import 'controller/help_and_support_controller.dart';

// ignore_for_file: must_be_immutable
class HelpAndSupportScreen extends GetWidget<HelpAndSupportController> {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 24.v,
                ),
                child: Column(
                    children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: appTheme.gray200,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: ExpansionTile(
                        iconColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: appTheme.redA200)),
                        title: Text(
                          '${index + 1}.  ' + 'msg_lorem_ipsum_dolor10'.tr,
                          style: theme.textTheme.titleSmall!
                              .copyWith(fontSize: 14),
                        ),
                        children: [
                          _buildFrame1(),
                        ],
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar() {
    return Container(
      decoration: AppDecoration.top,
      child: CustomAppBar(
        height: 53.v,
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
          onTap: () {
            Get.back();
          },
          imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 13.v,
            bottom: 16.v,
          ),
        ),
        title: AppbarSubtitle(
          text: "msg_help_and_support".tr,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame1() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 9.v,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 310.h,
                child: Text(
                  "msg_lorem_ipsum_dolor9".tr,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 16.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "msg_lorem_ipsum_dolor5".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
