import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/profile_screen/profile_screen.dart';

import '../models/your_interest_model.dart';

// ignore: must_be_immutable
class YourInterestChipWidget extends StatelessWidget {
  YourInterestChipWidget({
    Key? key,
    required this.text,
    required this.yourInterestModel,
  }) : super(key: key);

  YourInterestModel yourInterestModel;
  String text;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.all(8.v),
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
        avatar: CustomImageView(
          imagePath: matchStringAndGetInterestImage(text),
          height: 16.v,
          width: 15.h,
        ),
        selected: (yourInterestModel.isSelected?.value ?? false),
        backgroundColor: appTheme.red50,
        selectedColor: appTheme.red50,
        shape: (yourInterestModel.isSelected?.value ?? false)
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: appTheme.gray900.withOpacity(0.6),
                  width: 1.h,
                ),
                borderRadius: BorderRadius.circular(
                  18.h,
                ),
              )
            : RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  18.h,
                ),
              ),
        onSelected: (value) {
          yourInterestModel.isSelected!.value = value;
        },
      ),
    );
  }
}
