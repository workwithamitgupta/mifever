// ignore_for_file: must_be_immutable, sdk_version_since, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/like/like_model.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/my_chats_one_page/widgets/userprofile1_item_widget.dart';
import 'package:mifever/widgets/app_bar/appbar_title.dart';
import 'package:mifever/widgets/app_bar/appbar_trailing_image.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_bottom_bar.dart';
import 'package:skeletons/skeletons.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../chat_screen/controller/chat_controller.dart';
import '../chat_screen/models/chat_model.dart';
import '../upgrade_plan_dialogue/upgrage_plan_dialogue.dart';
import 'controller/my_chats_one_controller.dart';
import 'models/my_chats_one_model.dart';
import 'models/userprofile1_item_model.dart';

class MyChatsOnePage extends StatelessWidget {
  MyChatsOnePage({Key? key}) : super(key: key);

  MyChatsOneController controller =
      Get.put(MyChatsOneController(MyChatsOneModel().obs));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return isHome();
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseServices.getMatchUser(),
              builder: (context, matchSnapshot) {
                if (matchSnapshot.connectionState == ConnectionState.waiting) {
                  return SkeletonListView();
                }
                var _matchedData = matchSnapshot.data!.docs;
                List<LikeModel> _matchedUser = <LikeModel>[];
                _matchedUser.clear();
                _matchedUser = _matchedData
                    .map((e) =>
                        LikeModel.fromJson(e.data() as Map<String, dynamic>))
                    .toList();
                Set<dynamic> combinedSet = {};
                for (var x in _matchedUser) {
                  combinedSet.addAll(x.userIds!);
                }
                List<dynamic> combinedList = combinedSet.toList();
                combinedList.remove(PrefUtils.getId());
                return combinedList.isEmpty
                    ? _noUsers()
                    : ListView.builder(
                        itemCount: combinedList.length,
                        itemBuilder: (context, userIndex) {
                          return Container(
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseServices.getUserById(
                                    combinedList[userIndex]),
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SkeletonListView();
                                  }
                                  var data = userSnapshot.data!;
                                  UserModel _user = UserModel.fromJson(
                                      data.data() as Map<String, dynamic>);
                                  return StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseServices.getLastChats(
                                          _user.id!),
                                      builder: (context, chatSnapshot) {
                                        if (chatSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return SizedBox.shrink();
                                        }
                                        var data =
                                            chatSnapshot.data?.docs ?? [];
                                        List<ChatModel> _chats = <ChatModel>[];
                                        _chats.clear();
                                        _chats = data
                                            .map((e) => ChatModel.fromJson(
                                                e.data()
                                                    as Map<String, dynamic>))
                                            .toList();
                                        return Obx(
                                          () => Visibility(
                                            visible: controller.isVisible(
                                                _user.name.toString()),
                                            child: Userprofile1ItemWidget(
                                                Userprofile1ItemModel(
                                                    id: _user.id.toString().obs,
                                                    userImage:
                                                        _user.lifeAlbum?[0]
                                                            .toString()
                                                            .obs,
                                                    username: _user.name
                                                        .toString()
                                                        .obs,
                                                    greeting: _chats.length == 0
                                                        ? ''.obs
                                                        : lastMessages(_chats)
                                                            .obs,
                                                    timestamp: _chats.length == 0
                                                        ? ''.obs
                                                        : getTimeAgo(DateTime.parse(
                                                                _chats[0].timestamp ??
                                                                    ""))
                                                            .obs,
                                                    notificationCount:
                                                        messageCount(_chats) ==
                                                                0
                                                            ? ''.obs
                                                            : messageCount(_chats)
                                                                .toString()
                                                                .obs)),
                                          ),
                                        );
                                      });
                                }),
                          );
                        });
              }),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
        preferredSize: Size(SizeUtils.width, 56.v),
        child: Obx(() => controller.isSelected.value
            ? _buildDeleteScreenAppBar()
            : controller.isSearch.value
                ? TextFormField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      prefixIconConstraints: BoxConstraints(maxWidth: 50.v),
                      prefixIcon: CustomImageView(
                          margin: EdgeInsets.only(
                            left: 20.h,
                            top: 10.h,
                            right: 5.v,
                          ),
                          imagePath: ImageConstant.imgSearch),
                      contentPadding: EdgeInsets.only(top: 15.v),
                      border: InputBorder.none,
                      hintText: 'Search',
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.isSearch.value = false;
                          },
                          icon: Icon(Icons.close)),
                    ),
                    onChanged: (val) {
                      controller.query.value = val;
                    },
                  )
                : CustomAppBar(
                    title: AppbarTitle(
                      text: "lbl_my_chats".tr,
                      margin: EdgeInsets.only(left: 20.h),
                    ),
                    actions: [
                      AppbarTrailingImage(
                        onTap: () {
                          controller.isSearch.value = true;
                        },
                        imagePath: ImageConstant.imgSearch,
                        margin: EdgeInsets.fromLTRB(20.h, 12.v, 20.h, 19.v),
                      ),
                    ],
                  )));
  }

  /// Section Widget
  PreferredSizeWidget _buildDeleteScreenAppBar() {
    return CustomAppBar(
      height: 64.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          controller.selectedUser.clear();
          controller.isSelected.value = false;
        },
        imagePath: ImageConstant.imgArrowLeft02SharpPrimarycontainer,
        margin: EdgeInsets.only(
          left: 12.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      title: Obx(
        () => AppbarSubtitleOne(
          text: "${controller.selectedUser.length} " + "lbl_2_selected".tr,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ),
      actions: [
        AppbarTrailingImage(
          onTap: () {
            controller.onDeleteChat();
          },
          imagePath: ImageConstant.imgDelete01,
          margin: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 10.v,
          ),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  String lastMessages(List<ChatModel> _chats) {
    if (_chats.length == 0) {
      return '';
    } else if (_chats[0].type == MessageType.Voice.name) {
      return '🎵 ${_chats[0].type}';
    } else if (_chats[0].type == MessageType.Media.name) {
      return '📂 ${_chats[0].type}';
    } else if (_chats[0].type == MessageType.Video.name) {
      return '🎥 ${_chats[0].type}';
    } else if (_chats[0].type == MessageType.Text.name) {
      return '${_chats[0].message}';
    } else {
      return '';
    }
  }

  int messageCount(List<ChatModel> _chats) {
    int count = 0;
    if (_chats.isNotEmpty) {
      for (var chat in _chats) {
        if (chat.isSeen! && chat.receiverId == PrefUtils.getId()) {
          count++;
        }
      }
    }
    return count;
  }

  Widget _noUsers() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80.v,
            width: 136.h,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 80.adaptSize,
                    width: 80.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.h,
                      vertical: 16.v,
                    ),
                    decoration: AppDecoration.outlineRedA2002.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder40,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgLock,
                      height: 48.v,
                      width: 44.h,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse159880x80,
                  height: 80.adaptSize,
                  width: 80.adaptSize,
                  radius: BorderRadius.circular(
                    40.h,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ],
            ),
          ),
          SizedBox(height: 26.v),
          Text(
            "msg_find_your_matches".tr,
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.v),
          Text(
            "msg_it_s_a_match_if".tr,
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 22.v),
          CustomElevatedButton(
            onPressed: () {
              final controller = Get.find<CustomBottomBarController>();
              controller.selectedIndex.value = 0;
            },
            text: "lbl_keep_scrolling".tr,
            margin: EdgeInsets.only(left: 14.h),
          ),
          SizedBox(height: 24.v),
          CustomOutlinedButton(
            height: 42.v,
            text: "msg_upgrade_your_plan".tr,
            margin: EdgeInsets.only(left: 14.h),
            buttonStyle: CustomButtonStyles.outlineRedATL21,
            buttonTextStyle: CustomTextStyles.titleMediumRedA200,
            onPressed: () {
              Get.dialog(UpgradePlanDialogue());
              //Get.to(() => LikesPage());
            },
          ),
          SizedBox(height: 5.v),
        ],
      ),
    );
  }
}
