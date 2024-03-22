import 'dart:developer' as consol;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';
import 'package:mifever/presentation/chat_screen/widgets/doc_message_widget.dart';
import 'package:mifever/presentation/chat_screen/widgets/text_message_widget.dart';
import 'package:mifever/presentation/chat_screen/widgets/voice_message_widget.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:mifever/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:mifever/widgets/custom_text_form_field.dart';

import '../../data/sevices/media_services/audio_services.dart';
import '../../widgets/app_bar/appbar_subtitle_three.dart';
import '../chat_three_dialog/chat_three_dialog.dart';
import '../profile_screen/profile_screen.dart';
import 'controller/chat_controller.dart';
import 'widgets/video_message_widget.dart';

// ignore_for_file: must_be_immutable
class ChatScreen extends GetWidget<ChatController> {
  ChatScreen(this.id, {Key? key}) : super(key: key);
  final String id;
  final controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(Get.width, 64.v), child: _buildAppBar()),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseServices.getChats(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink();
              }
              var data = snapshot.data!.docs;
              List<ChatModel> _chats = <ChatModel>[];
              _chats.clear();
              // _chats = data
              //     .map((e) =>
              //         ChatModel.fromJson(e.data() as Map<String, dynamic>))
              //     .toList();
              _chats = data.map((e) {
                var data = e.data() as Map<String, dynamic>;
                data['dcoId'] = e.id;
                return ChatModel.fromJson(data);
              }).toList();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildFliteFrame(),
                    _buildDisclaimer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 20.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              _chats.length,
                              (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 10.v),
                                    child: getWidget(_chats[index]),
                                  ))),
                    ),
                    SizedBox(
                      height: 70.v,
                    )
                  ],
                ),
              );
            }),
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseServices.getBlockByUser(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox.shrink();
                  }
                  var data = snapshot.data!.docs;
                  bool _isBlocked = data.isNotEmpty;
                  return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseServices.getBlockUser(id),
                      builder: (context, blockSnapshot) {
                        if (blockSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox.shrink();
                        }
                        var blockSnapshotData = blockSnapshot.data!.docs;
                        String docId = '';
                        for (var doc in blockSnapshotData) {
                          docId = doc.id;
                        }
                        bool _isBlockedByMe = blockSnapshotData.isNotEmpty;
                        return _isBlockedByMe
                            ? _buildBlockedByMeWidget(docId)
                            : _isBlocked
                                ? _blockedMeWidget()
                                : _buildSendMessage();
                      });
                }),
            Obx(
              () => Visibility(
                  visible: controller.emojiShowing.value,
                  child: _openEmojiKeyboard()),
            ),
          ],
        ),
      ),
    );
  }

  _blockedMeWidget() {
    return Container(
      padding: EdgeInsets.all(20.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'lbl_you_blocked_by'.tr + ' ${controller.userName}',
            style: TextStyle(fontSize: 12.fSize),
          ),
        ],
      ),
    );
  }

  _buildBlockedByMeWidget(String docId) {
    return Container(
      padding: EdgeInsets.all(20.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You Blocked ${controller.userName} Want to',
            style: TextStyle(fontSize: 12.fSize),
          ),
          TextButton(
              onPressed: () async {
                await FirebaseServices.unBlockUser(docId);
                Fluttertoast.showToast(msg: 'Unblocked');
              },
              child: Text(
                'Unblock'.toUpperCase(),
                style: TextStyle(fontSize: 12.fSize, color: appTheme.redA200),
              ))
        ],
      ),
    );
  }

  Align _buildDayWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 80.h,
        padding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 5.v,
        ),
        decoration: AppDecoration.fillGray200.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Text(
          "lbl_yesterday".tr,
          style: CustomTextStyles.labelMediumGray60004,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUserById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          var data = snapshot.data;
          UserModel user = UserModel();
          user = UserModel.fromJson(data!.data() as Map<String, dynamic>);
          controller.userName.value = user.name!;
          return Container(
            decoration: AppDecoration.top,
            child: CustomAppBar(
              height: 64.v,
              leadingWidth: 40.h,
              leading: AppbarLeadingImage(
                onTap: () {
                  Get.back();
                },
                imagePath: ImageConstant.imgArrowLeft02SharpPrimarycontainer,
                margin: EdgeInsets.only(
                  left: 16.h,
                  top: 20.v,
                  bottom: 20.v,
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Row(
                  children: [
                    AppbarTitleCircleimage(
                      onTap: () {
                        Get.to(() => ProfileScreen(id));
                      },
                      imagePath: user.wayAlbum![0],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppbarSubtitleOne(
                              text: user.name.toString().capitalize ?? ''
                              // "lbl_theresa_webb".tr,
                              ),
                          SizedBox(height: 3.v),
                          Visibility(
                            visible: isOnline(user.lasOnline!),
                            child: AppbarSubtitleThree(
                              text: "lbl_online".tr,
                              margin: EdgeInsets.only(right: 60.h),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                CustomImageView(
                  imagePath: ImageConstant.imgVideo02,
                  alignment: Alignment.center,
                ),
                SizedBox(width: 20.v),
                CustomImageView(
                  width: 22.v,
                  height: 22.v,
                  imagePath: ImageConstant.imgCalling,
                  alignment: Alignment.center,
                ),
                SizedBox(width: 20.v),
              ],
            ),
          );
        });
  }

  /// Section Widget
  Widget _buildMessage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 20, spreadRadius: 0.2),
        ]),
        child: CustomTextFormField(
          onTap: () {
            controller.emojiShowing.value = false;
          },
          controller: controller.messageController,
          hintText: "msg_type_message_here".tr,
          hintStyle: theme.textTheme.bodySmall!,
          textInputAction: TextInputAction.done,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(12.h, 14.v, 5.h, 14.v),
            child: CustomImageView(
              onTap: () {
                FocusScope.of(Get.context!).unfocus();
                controller.emojiShowing.value = !controller.emojiShowing.value;
              },
              imagePath: ImageConstant.imgIconEmoji,
              height: 20.adaptSize,
              width: 20.adaptSize,
              color: controller.emojiShowing.value ? appTheme.redA200 : null,
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: 48.v,
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.v),
                child: CustomImageView(
                  onTap: () async {
                    await FirebaseServices.sendMediaChat(id);
                  },
                  imagePath: ImageConstant.imgAttachment01,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.v),
                child: CustomImageView(
                  onTap: () async {
                    await FirebaseServices.sendVideoChat(id);
                  },
                  imagePath: ImageConstant.imgCamera01,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.v, right: 10.v, top: 5.v),
                child: CustomIconButton(
                  onTap: () {
                    controller.senMessage(id);
                  },
                  height: 36.adaptSize,
                  width: 36.adaptSize,
                  padding: EdgeInsets.all(8.h),
                  alignment: Alignment.topRight,
                  decoration: IconButtonStyleHelper.fillRedA,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgSend2,
                  ),
                ),
              ),
            ],
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 48.v,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15.v),
          borderDecoration: TextFormFieldStyleHelper.outlineOnPrimary,
          filled: true,
          fillColor: theme.colorScheme.primary,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFliteFrame() {
    return Container(
      decoration: AppDecoration.top,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgTicketStar,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 5.v,
                  ),
                  child: Text(
                    "msg_flights_recommendations".tr,
                    style: CustomTextStyles.labelLargeBlack900,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.dialog(Center(child: ChatThreeDialog()));
                  },
                  child: Text(
                    "lbl_view_now".tr,
                    style: CustomTextStyles.titleSmallRedA200,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: EdgeInsets.all(10.h),
      margin: EdgeInsets.all(20.v),
      width: SizeUtils.width,
      height: 78.h,
      decoration: BoxDecoration(
          color: appTheme.redA200, borderRadius: BorderRadius.circular(4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          SizedBox(width: 8.v),
          Flexible(
            child: Text(
              "msg_please_do_not_send".tr,
              style: CustomTextStyles.bodySmallPrimary_1,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSendMessage() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 30.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => controller.isRecording.value
                ? _buildVoiceRecord()
                : _buildMessage(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: GestureDetector(
              onLongPressMoveUpdate: (details) async {
                Offset myOffset = details.localOffsetFromOrigin;
                double firstValue = myOffset.dx;
                if (firstValue < -30.0) {
                  consol.log('isVoiceCancel');
                  controller.isVoiceCancel.value = true;
                  await VoiceRecorderController.stopRecording();
                }
              },
              onLongPressEnd: (val) async {
                controller.isRecordingOn(false);
                controller.stopTimer();
                controller.isRecording(false);
                if (!controller.isVoiceCancel.value) {
                  await VoiceRecorderController.stopRecording();
                  consol.log(VoiceRecorderController.recordingPath.value);
                  await controller.sendVoiceMessage(
                      receiverId: id,
                      path: VoiceRecorderController.recordingPath.value);
                }
                controller.isVoiceCancel.value = false;
              },
              onLongPress: () async {
                consol.log('onLongPress');
                controller.isRecording(true);
                await VoiceRecorderController.startRecording();
                controller.isRecordingOn(true);
                controller.startTimer();
              },
              child: CustomIconButton(
                onTap: null,
                height: 48.adaptSize,
                width: 48.adaptSize,
                padding: EdgeInsets.all(12.h),
                decoration: IconButtonStyleHelper.fillRed,
                child: CustomImageView(
                  onTap: null,
                  imagePath: ImageConstant.imgMic01RedA200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceRecord() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 12.h),
            const Icon(
              Icons.mic,
              color: Colors.red,
            ),
            Obx(
              () => Text(
                controller.formatTime(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Text(
              '<< Swipe Left to Cancel',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _openEmojiKeyboard() {
    return EmojiPicker(
      textEditingController: controller.messageController,
      onEmojiSelected: (Category? category, Emoji emoji) {},
      onBackspacePressed: () {
        controller.emojiShowing.value = false;
      },
      config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        swapCategoryAndBottomBar: false,
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: CategoryViewConfig(
            iconColorSelected: appTheme.redA200,
            indicatorColor: appTheme.redA200),
        bottomActionBarConfig: BottomActionBarConfig(
            buttonIconColor: appTheme.redA200,
            buttonColor: Colors.white,
            backgroundColor: Colors.white),
        searchViewConfig: SearchViewConfig(),
      ),
    );
  }

  isOnline(Timestamp savedTimestamp) {
    DateTime savedDateTime = savedTimestamp.toDate();
    DateTime currentDateTime = DateTime.now();
    int differenceInSeconds =
        currentDateTime.difference(savedDateTime).inSeconds;
    bool isWithinOneMinute = differenceInSeconds < 120;
    return isWithinOneMinute;
  }

  Widget getWidget(ChatModel chat) {
    switch (chat.type) {
      case 'Text':
        return TextMessageWidget(chat: chat);
      case 'Voice':
        return VoiceMessageWidget(chat: chat);
      case 'Media':
        return DocMessageWidget(chat: chat);
      case 'Video':
        return VideoMessageWidget(chat: chat);
      default:
        return Text('No Widget Found');
    }
  }
}
