import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';

import 'controller/privacy_and_policy_controller.dart';

// ignore_for_file: must_be_immutable
class PrivacyAndPolicyScreen extends GetWidget<PrivacyAndPolicyController> {
  const PrivacyAndPolicyScreen({Key? key}) : super(key: key);

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
                              'Privacy Policy for MiFever: Travel Dating Application\n\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'At MiFever, safeguarding your privacy is paramount. This Privacy Policy elucidates the manner in which we collect, utilize, disclose, and secure your personal information while using our travel dating application, MiFever.\n\n',
                        ),
                        TextSpan(
                          text: '1. Information We Collect:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. Personal Information: Upon registering with MiFever, we may collect personal data, including your name, email address, gender, date of birth, and location.\n\n'
                              'b. Profile Information: Your profile on MiFever may comprise additional details such as photos, interests, hobbies, and travel preferences.\n\n'
                              'c. Communication Data: We may gather information exchanged within the application, including messages, chats, and other forms of communication between users.\n\n',
                        ),
                        TextSpan(
                          text: '2. How We Use Your Information:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. Enhancing User Experience: We utilize the collected data to tailor your MiFever experience, providing personalized matches and travel recommendations.\n\n'
                              'b. Communication: Your information enables us to facilitate communication between users, fostering connections and interactions within the MiFever community.\n\n'
                              'c. Service Improvement: We analyze user data to improve and optimize MiFever\'s features, functionality, and overall performance.\n\n',
                        ),
                        TextSpan(
                          text: '3. Information Sharing and Disclosure:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. With Your Consent: We may share your information with third parties for services you explicitly consent to, such as travel bookings or partner promotions.\n\n'
                              'b. Legal Obligations: In certain circumstances, we may disclose your data to comply with legal obligations, enforce our policies, or protect the rights, property, or safety of MiFever and its users.\n\n',
                        ),
                        TextSpan(
                          text: '4. Data Security:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. Encryption: We employ industry-standard encryption techniques to safeguard your personal information against unauthorized access, alteration, or disclosure.\n\n'
                              'b. Security Measures: MiFever implements robust security measures to protect against data breaches, including firewalls, access controls, and regular security audits.\n\n',
                        ),
                        TextSpan(
                          text: '5. User Control and Rights:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. Access and Correction: You have the right to access and update your personal information stored on MiFever. You can modify your profile settings or contact us directly for assistance.\n\n'
                              'b. Data Deletion: You may request the deletion of your MiFever account and associated data. However, certain information may be retained for legal or administrative purposes.\n\n',
                        ),
                        TextSpan(
                          text: '6. Policy Updates:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'a. Notification: We will notify users of any material changes to this Privacy Policy via email or within the MiFever application.\n\n'
                              'b. Review: We recommend reviewing this Privacy Policy periodically to stay informed about how we collect, use, and protect your personal information.\n\n',
                        ),
                        TextSpan(
                          text: '7. Contact Us:\n',
                          style: CustomTextStyles.titleMediumGray900,
                        ),
                        TextSpan(
                          text:
                              'If you have any questions, concerns, or feedback regarding this Privacy Policy or MiFever\'s data practices, please contact us at [contact@email.com].\n\n',
                        ),
                        TextSpan(
                          text:
                              'By using MiFever, you signify your acceptance of this Privacy Policy. If you do not agree with any aspect of this policy, please refrain from using the application.',
                        ),
                      ],
                    ),
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
          text: "msg_privacy_and_policy".tr,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ),
    );
  }
}
