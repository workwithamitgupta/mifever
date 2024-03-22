import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/profile_controller.dart';

// ignore: must_be_immutable
class CarouselSliderItemWidget extends StatelessWidget {
  CarouselSliderItemWidget(this.url, {Key? key}) : super(key: key);

  String url;

  var controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: url,
      //ImageConstant.imgRectangle17848,
      height: 295.v,
      width: 375.h,
      fit: BoxFit.cover,
    );
  }
}
