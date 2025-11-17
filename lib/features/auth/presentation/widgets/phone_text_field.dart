import 'package:flutter/material.dart';
import 'package:weam/core/app_theme/app_colors.dart';
import 'package:weam/features/shared_widget/custom_text_form_field.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController? controller;
  const PhoneTextField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: "رقم الهاتف",
      filled: true,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "برجاء ادخال رقم الهاتف";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.phone,
      fillColor: AppColors.whiteColor,
    );
  }
}
