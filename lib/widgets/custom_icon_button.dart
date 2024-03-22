import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(32.h),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onPrimary.withOpacity(1),
                      spreadRadius: 2.h,
                      blurRadius: 2.h,
                      offset: Offset(
                        3,
                        2,
                      ),
                    ),
                  ],
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillRedA => BoxDecoration(
        color: appTheme.redA200,
        borderRadius: BorderRadius.circular(18.h),
      );
  static BoxDecoration get fillRedATL15 => BoxDecoration(
        color: appTheme.redA200,
        borderRadius: BorderRadius.circular(15.h),
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red50,
        borderRadius: BorderRadius.circular(24.h),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
  static BoxDecoration get radiusTL36 => BoxDecoration(
        borderRadius: BorderRadius.circular(36.h),
      );
  static BoxDecoration get outlinePrimaryTL32 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(32.h),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(36.h),
      );
  static BoxDecoration get fillPrimaryTL40 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(40.h),
      );
  static BoxDecoration get fillRedATL40 => BoxDecoration(
        color: appTheme.redA200,
        borderRadius: BorderRadius.circular(40.h),
      );
  static BoxDecoration get outlinePrimaryTL20 => BoxDecoration(
        color: appTheme.redA200,
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2.h,
        ),
      );
  static BoxDecoration get fillRedTL36 => BoxDecoration(
        color: appTheme.red50,
        borderRadius: BorderRadius.circular(36.h),
      );
  static BoxDecoration get outlinePrimaryTL15 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        borderRadius: BorderRadius.circular(15.h),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
}
