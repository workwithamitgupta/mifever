// ignore_for_file: sdk_version_since

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/sevices/media_services/audio_services.dart';
import '../../widgets/custom_outlined_button.dart';
import '../about_me_page/models/describeathings_item_model.dart';
import 'controller/profile_controller.dart';
import 'widgets/carousel_item_widget.dart';
import 'widgets/frametwentythree_item_widget.dart';

// ignore_for_file: must_be_immutable
class ProfileScreen extends GetWidget<ProfileController> {
  ProfileScreen(this.id, {Key? key}) : super(key: key);
  final String id;
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    controller.addThermometer(id);
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseServices.getUserById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox.shrink();
            }
            var data = snapshot.data;
            UserModel user =
                UserModel.fromJson(data!.data() as Map<String, dynamic>);
            return Scaffold(
              appBar: _buildAppBar(user),
              body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 24.v),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.v),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.h),
                            child: Obx(
                              () => Row(
                                children: [
                                  CustomOutlinedButton(
                                    height: 36.v,
                                    width: 105.h,
                                    text: "lbl_way_album".tr,
                                    buttonStyle: controller.isWayAlbum.value
                                        ? CustomButtonStyles.fillRedATL18
                                        : CustomButtonStyles.outlineGray,
                                    buttonTextStyle: controller.isWayAlbum.value
                                        ? CustomTextStyles.titleSmallPrimary
                                        : CustomTextStyles.titleSmallGray60004,
                                    onPressed: () {
                                      controller.isWayAlbum.value = true;
                                    },
                                  ),
                                  CustomOutlinedButton(
                                    width: 102.h,
                                    text: "lbl_life_album".tr,
                                    buttonTextStyle: !controller
                                            .isWayAlbum.value
                                        ? CustomTextStyles.titleSmallPrimary
                                        : CustomTextStyles.titleSmallGray60004,
                                    margin: EdgeInsets.only(left: 12.h),
                                    buttonStyle: !controller.isWayAlbum.value
                                        ? CustomButtonStyles.fillRedATL18
                                        : CustomButtonStyles.outlineGray,
                                    onPressed: () {
                                      controller.isWayAlbum.value = false;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.v),
                        Obx(() => _buildCarouselSlider(
                              controller.isWayAlbum.value
                                  ? user.wayAlbum ?? []
                                  : user.lifeAlbum ?? [],
                            )),
                        SizedBox(height: 16.v),
                        Obx(
                          () => SizedBox(
                            height: 6.v,
                            child: AnimatedSmoothIndicator(
                              activeIndex: controller.sliderIndex.value,
                              count: user.wayAlbum?.length ?? 0,
                              axisDirection: Axis.horizontal,
                              effect: ScrollingDotsEffect(
                                spacing: 4,
                                activeDotColor:
                                    theme.colorScheme.onPrimary.withOpacity(1),
                                dotColor: appTheme.gray200,
                                dotHeight: 6.v,
                                dotWidth: 6.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.v),
                        _buildVoiceRecording(user),
                        _buildInterests(user),
                        _buildQuestionAnswer(
                          aboutMyFavorite: "lbl_here_for".tr,
                          loremIpsumDolor: user.whatDoYouWant.toString().tr,
                        ),
                        _buildAvailableLocation(user),
                        _buildAboutMe(user),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(UserModel user) {
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
        text: user.name.toString().capitalize ?? '',
        //"lbl_amy_johns_25".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: 'BLOCK',
                  child: Text(
                    'Block',
                    style: CustomTextStyles.titleSmallGray60004,
                  )),
              PopupMenuItem(
                  value: 'REPORT',
                  child: Text(
                    'Report',
                    style: CustomTextStyles.titleSmallGray60004,
                  )),
            ];
          },
          onSelected: (val) {
            if (val == 'BLOCK') {
              Get.toNamed(AppRoutes.blockProflieScreen, arguments: [id]);
            }
          },
        )
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildCarouselSlider(List list) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 295.v,
        initialPage: 0,
        autoPlay: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (
          index,
          reason,
        ) {
          controller.sliderIndex.value = index;
        },
      ),
      itemCount: list.length,
      itemBuilder: (context, index, realIndex) {
        return CarouselSliderItemWidget(
          list[index],
        );
      },
    );
  }

  /// Section Widget
  Widget _buildVoiceRecording(UserModel user) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
          decoration: AppDecoration.outlineRed50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 3.v),
              Text(
                "lbl_voice_recording".tr,
                style: CustomTextStyles.titleMediumGray900ExtraBold,
              ),
              SizedBox(height: 8.v),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                color: appTheme.red50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                ),
                child: Container(
                  padding: EdgeInsets.all(10.v),
                  height: 54.v,
                  width: 335.h,
                  decoration: AppDecoration.fillRed.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder4,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 11.v),
                                child: Container(
                                  height: 8.v,
                                  width: 269.h,
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
                                    child: Obx(
                                      () => LinearProgressIndicator(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        minHeight: 8.v,
                                        value: controller.progress.value,
                                        color: appTheme.redA200,
                                        backgroundColor: appTheme.red100,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: CustomIconButton(
                                onTap: () {
                                  controller.progress.value = 0.0;
                                  controller.isPlaying.value = true;
                                  VoiceRecorderController.playAudio(
                                          user.nameAudio ?? '')
                                      .then((value) => VoiceRecorderController
                                          .audioPosition.value = 0);
                                },
                                height: 30.adaptSize,
                                width: 30.adaptSize,
                                padding: EdgeInsets.all(6.h),
                                decoration: IconButtonStyleHelper.fillRedATL15,
                                child: Obx(
                                  () => controller.isPlaying.value
                                      ? Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                          size: 15.h,
                                        )
                                      : CustomImageView(
                                          imagePath: ImageConstant.imgFavorite,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 147.h,
                              vertical: 7.v,
                            ),
                            decoration: AppDecoration.fillPrimary2.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder4,
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgClose,
                              height: 40.adaptSize,
                              width: 40.adaptSize,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: PrefUtils.getUserGender() == 'Female' ||
                controller.planName.value.isEmpty,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 167.h,
                  vertical: 32.v,
                ),
                decoration: AppDecoration.fillPrimary1,
                child: CustomImageView(
                  imagePath: ImageConstant.imgGroup25,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildInterests(UserModel user) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_interests".tr,
            style: CustomTextStyles.titleMediumGray900ExtraBold,
          ),
          SizedBox(height: 10.v),
          Wrap(
            runSpacing: 12.v,
            spacing: 12.h,
            children: List<Widget>.generate(
              user.interestList?.length ?? 0,
              (index) {
                return InterestChipWidget(
                  user.interestList?[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAvailableLocation(UserModel user) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(20.h, 24.v, 20.h, 22.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "msg_available_locations".tr,
            style: CustomTextStyles.titleMediumGray900ExtraBold,
          ),
          SizedBox(height: 8.v),
          Wrap(
            runSpacing: 12.v,
            spacing: 12.h,
            children: List<Widget>.generate(
              user.availableCity?.length ?? 0,
              (index) {
                return _buildLocationChip(
                    '${user.availableCity?[index]},${user.availableCountry?[index]}');
              },
            ),
          ),
        ],
      ),
    );
  }

  RawChip _buildLocationChip(String text) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        text,
        style: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.fSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: appTheme.red50,
      selectedColor: appTheme.red50,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.gray900.withOpacity(0.6),
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          18.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAboutMe(UserModel _user) {
    Rx<List<DescribeathingsItemModel>> aboutMe = Rx([
      DescribeathingsItemModel(
          question: "Describe a Things You really like to do".obs,
          answer: _user.aboutMe?.thingsYouLike.obs,
          key: 'thingsYouLike'.obs),
      DescribeathingsItemModel(
        question: "Describe a Things I love about my culture".obs,
        answer: _user.aboutMe?.aboutMyCulture.obs,
        key: 'aboutMyCulture'.obs,
      ),
      DescribeathingsItemModel(
          question: "Describe What kind of person You are.".obs,
          answer: _user.aboutMe?.whatKindPerson.obs,
          key: 'whatKindPerson'.obs),
      DescribeathingsItemModel(
          question:
              "Describe your hobbies and activities that you like to participate in."
                  .obs,
          answer: _user.aboutMe?.hobbiesAndActivity.obs,
          key: 'hobbiesAndActivity'.obs),
      DescribeathingsItemModel(
          question: "Describe About you Favorite Location".obs,
          answer: _user.aboutMe?.favLocation.obs,
          key: 'favLocation'.obs)
    ]);

    return Column(
      children: List.generate(
          aboutMe.value.length,
          (index) => Container(
                height: 160.v,
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 1.v),
                //decoration: AppDecoration.outlineRed50,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    _buildQuestionAnswer(
                        aboutMyFavorite: aboutMe.value[index].question!.value,
                        loremIpsumDolor: aboutMe.value[index].answer!.value),
                    Obx(
                      () => Visibility(
                        visible: PrefUtils.getUserGender() == 'Female' ||
                            controller.planName.value.isEmpty,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 167.h,
                              vertical: 32.v,
                            ),
                            decoration: AppDecoration.fillPrimary1,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgGroup25,
                              height: 40.adaptSize,
                              width: 40.adaptSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }

  /// Common widget
  Widget _buildQuestionAnswer({
    required String aboutMyFavorite,
    required String loremIpsumDolor,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.h, 21.v, 20.h, 19.v),
      decoration: AppDecoration.outlineRed50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.v),
          Text(
            aboutMyFavorite,
            style: CustomTextStyles.titleMediumGray900ExtraBold.copyWith(
              color: appTheme.gray900,
            ),
          ),
          SizedBox(height: 7.v),
          Container(
            width: 307.h,
            margin: EdgeInsets.only(right: 27.h),
            child: Text(
              loremIpsumDolor,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: appTheme.gray60004,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List palyList = [
  'Movie',
  'Gaming',
  'Nature',
  'Photography',
  'Gym & Fitness',
  'Sports',
  'Design',
  'Dancing',
  'Reading',
  'Music',
  'Writing',
  'Cooking',
  'Animals',
];

List palyListImg = [
  ImageConstant.imgPlaylist,
  ImageConstant.imgGamecontroller03,
  ImageConstant.imgSailboatoffshore,
  ImageConstant.imgCamera01,
  ImageConstant.imgDumbbell02,
  ImageConstant.imgBasketball01,
  ImageConstant.imgMaximize,
  ImageConstant.imgMdihumanfemaledance,
  ImageConstant.imgNotebook,
  ImageConstant.imgMusicnote03,
  ImageConstant.imgUser,
  ImageConstant.imgDish01,
  ImageConstant.imgTelevision,
];

// Method to match a string from one list to another list
String matchStringAndGetInterestImage(String inputString) {
  int index = palyList.indexOf(inputString);
  if (index != -1 && index < palyListImg.length) {
    return palyListImg[index];
  } else {
    return ImageConstant.imgPlaylist;
  }
}
