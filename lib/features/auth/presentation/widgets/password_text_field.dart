import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/core/assets_path/svg_path.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../shared_widget/custom_text_form_field.dart';

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const PasswordTextField({super.key, this.hintText, this.controller, this.validator});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isNotVisible = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      hintText: widget.hintText ?? "كلمة المرور",
      filled: true,
      isNotVisible: isNotVisible,
      maxLines: 1,
      validator: widget.validator??(value){
        if(value!.isEmpty){
          return "برجاء ادخال كلمة المرور";
        }else if(value.length<6){
          return "يجب ادخال اكثر من 6 حروف";
        }else{
          return null;
        }
      },
      fillColor: AppColors.whiteColor,
      suffixIcon: IconButton(
        onPressed: () {
          isNotVisible=!isNotVisible;
          setState(() {

          });
        },
        icon: SvgPicture.asset(
          isNotVisible?SvgPath.eyeClosed:SvgPath.eyeOpen,
          colorFilter: const ColorFilter.mode(
            AppColors.greyColorD3,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
