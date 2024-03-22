// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../core/app_export.dart';

class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField({
    Key? key,
    required this.context,
    required this.onChanged,
    this.alignment,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
    this.onCompleted,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 4,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? theme.textTheme.titleSmall,
        hintStyle: hintStyle ?? theme.textTheme.titleSmall,
        errorTextDirection: TextDirection.rtl,
        errorTextMargin: EdgeInsets.only(top: 5.h),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        pinTheme: PinTheme(
            fieldHeight: 44.h,
            fieldWidth: 44.h,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(4.h),
            inactiveColor: appTheme.gray200,
            activeColor: appTheme.gray200,
            selectedColor: appTheme.redA200),
        onChanged: (value) => onChanged(value),
        validator: validator,
        onCompleted: onCompleted,
      );
}
