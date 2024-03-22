import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';

import 'controller/terms_and_conditions_controller.dart';

// ignore_for_file: must_be_immutable
class TermsAndConditionsScreen extends GetWidget<TermsAndConditionsController> {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildFrame(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodySmall!.copyWith(
                        height: 1.50,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Terms and Conditions for MiFever: Travel Dating Application\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'Terms and Conditions for MiFever: Travel Dating Application These Terms and Conditions govern your use of the MiFever travel dating application. By accessing or using MiFever, you agree to abide by these terms. Please read them carefully before using the application',
                          style: theme.textTheme.bodySmall!.copyWith(
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n\n1. Acceptance of Terms:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. By using MiFever, you acknowledge that you have read, understood, and agreed to these Terms and Conditions, as well as our Privacy Policy.\nb. If you do not agree with any provision of these terms, you should refrain from using MiFever.',
                          style: theme.textTheme.bodySmall!.copyWith(
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n\n 2. Eligibility:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              ' a. You must be at least 18 years old to use MiFever. By accessing or using the application, you represent and warrant that you are of legal age to form a binding contract.',
                          style: theme.textTheme.bodySmall!.copyWith(
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n\n 3. Account Registration:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              " a. You are required to create an account to access certain features of MiFever. When registering, you must provide accurate and complete information and promptly update your profile as necessary.\nb. You are solely responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.",
                        ),
                        TextSpan(
                          text: '\n\n 4. User Conduct:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              "  a. You agree to use MiFever for lawful purposes only and in compliance with these Terms and Conditions, as well as applicable laws and regulations.\nb. You must not engage in any conduct that may disrupt, damage, or impair the functionality of MiFever or interfere with other users' enjoyment of the application.",
                        ),
                        TextSpan(
                          text: '\n\n 5. Content Guidelines:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              "  a. You are solely responsible for the content you post on MiFever, including profile information, photos, and messages.",
                        ),
                        TextSpan(
                          text: '\n\n 6. Intellectual Property:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              "  b. You must not post any content that is defamatory, obscene, offensive, unlawful, or infringes upon the rights of others.",
                        ),
                        TextSpan(
                          text: '\n\n 7. Privacy:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              "  b. You must not post any content that is defamatory, obscene, offensive, unlawful, or infringes upon the rights of others.",
                        ),
                        TextSpan(
                          text: '\n\n 8. Termination:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              "    a. MiFever reserves the right to suspend or terminate your access to the application at any time and for any reason, without prior notice or liability.b. Upon termination, all provisions of these Terms and Conditions that by their nature should survive termination will remain in full force and effect.",
                        ),
                        TextSpan(
                          text: '\n\n9. Disclaimer of Warranties:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. MiFever is provided on an "as is" and "as available" basis without warranties of any kind, whether express or implied.\n\n'
                              'b. We do not warrant that MiFever will be error-free, uninterrupted, or free from viruses or other harmful components.\n\n',
                        ),
                        TextSpan(
                          text: '10. Limitation of Liability:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. MiFever and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the application.\n\n'
                              'b. In no event shall our total liability to you exceed the amount paid by you, if any, for using MiFever.\n\n',
                        ),
                        TextSpan(
                          text: '11. Governing Law:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. These Terms and Conditions shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflict of law provisions.\n\n',
                        ),
                        TextSpan(
                          text: '12. Changes to Terms:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. MiFever reserves the right to modify or update these Terms and Conditions at any time without prior notice. Continued use of the application after such changes constitutes your acceptance of the revised terms.\n\n',
                        ),
                        TextSpan(
                          text: '13. Contact Us:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'If you have any questions or concerns about these Terms and Conditions, please contact us at [contact@email.com].\n\n',
                        ),
                        TextSpan(
                          text:
                              'By using MiFever, you agree to be bound by these Terms and Conditions. If you do not agree with any provision of these terms, please discontinue use of the application.',
                        ),
                      ],
                    ),
                  ),
                ),

                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20.h,
                //     vertical: 7.v,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: 19.v),
                //       Text(
                //         "msg_lorem_ipsum_dolor5".tr,
                //         style: CustomTextStyles.titleMediumGray900,
                //       ),
                //       SizedBox(height: 12.v),
                //       SizedBox(
                //         width: 333.h,
                //         child: Text(
                //           "msg_lorem_ipsum_dolor7".tr,
                //           maxLines: 12,
                //           overflow: TextOverflow.ellipsis,
                //           style: theme.textTheme.bodySmall!.copyWith(
                //             height: 1.50,
                //           ),
                //         ),
                //       ),
                //       SizedBox(height: 24.v),
                //       Text(
                //         "msg_lorem_ipsum_dolor5".tr,
                //         style: CustomTextStyles.titleMediumGray900,
                //       ),
                //       SizedBox(height: 12.v),
                //       Container(
                //         width: 310.h,
                //         margin: EdgeInsets.only(right: 24.h),
                //         child: Text(
                //           "msg_lorem_ipsum_dolor8".tr,
                //           maxLines: 5,
                //           overflow: TextOverflow.ellipsis,
                //           style: theme.textTheme.bodySmall!.copyWith(
                //             height: 1.50,
                //           ),
                //         ),
                //       ),
                //       SizedBox(height: 24.v),
                //       Text(
                //         "msg_lorem_ipsum_dolor5".tr,
                //         style: CustomTextStyles.titleMediumGray900,
                //       ),
                //       SizedBox(height: 12.v),
                //       SizedBox(
                //         width: 333.h,
                //         child: Text(
                //           "msg_lorem_ipsum_dolor7".tr,
                //           maxLines: 12,
                //           overflow: TextOverflow.ellipsis,
                //           style: theme.textTheme.bodySmall!.copyWith(
                //             height: 1.50,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrame() {
    return Container(
      decoration: AppDecoration.top,
      child: CustomAppBar(
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
          text: "msg_terms_conditions".tr,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ),
    );
  }
}
