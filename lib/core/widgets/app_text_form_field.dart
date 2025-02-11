import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final String? prefixIconImg;
  final bool isvalid;
  final String? suffixIconImg;
  final Color? suffixIconImgcolor;
  final bool isValidsuffixIcon;
  final AutovalidateMode? autovalidateMode;

  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function()? onsuffixIconTap;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextAlignVertical? textAlignVertical;
  final Color? fillColor;
  const AppTextFormField({
    super.key,
    this.hintText,
    this.prefixIconImg,
    this.suffixIconImg,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.suffixIconImgcolor,
    this.isValidsuffixIcon = false,
    this.isvalid = false,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.onsuffixIconTap,
    this.autovalidateMode,
    this.autofocus = false,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.textAlignVertical,
    this.fillColor = const Color(0xffF9FAFB),
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: textAlignVertical,
      onChanged: onChanged,
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
      // cursorColor: const Color(0xffE5E7EB),

      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        filled: true,
        counterStyle: const TextStyle(color: Color(0xffFF5C5C)),
        fillColor:
            Get.isDarkMode ? null : Theme.of(context).colorScheme.surface,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xffa1a8b0)),
        labelText: hintText,
        hintTextDirection: TextDirection.rtl,
        labelStyle: const TextStyle(color: Color(0xffADADAD)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIconImg == null
            ? null
            : Image.asset(
                prefixIconImg!,
                height: 24.h,
                width: 24.w,
                color: isvalid ? Theme.of(context).colorScheme.primary : null,
              ),
        suffixIcon: suffixIconImg == null
            ? null
            : InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: onsuffixIconTap,
                child: Image.asset(
                  suffixIconImg!,
                  height: 24.h,
                  width: 24.w,
                  color: isValidsuffixIcon
                      ? Theme.of(context).colorScheme.primary
                      : suffixIconImgcolor,
                ),
              ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1.5.w,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(24.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: const Color(0xffE5E7EB)),
            borderRadius: BorderRadius.circular(24.r)),
        errorBorder: OutlineInputBorder(
          gapPadding: 1,
          borderSide: BorderSide(width: 1.5.w, color: const Color(0xffFF5C5C)),
          borderRadius: BorderRadius.circular(24.r), // 0xffFF5C5C
        ),
        focusedErrorBorder: OutlineInputBorder(
          gapPadding: 1,
          borderSide: BorderSide(width: 1.5.w, color: const Color(0xffFF5C5C)),
          borderRadius: BorderRadius.circular(24.r), // 0xffFF5C5C
        ),
        errorStyle: const TextStyle(color: Color(0xffFF5C5C)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: const Color(0xffE5E7EB)),
            borderRadius: BorderRadius.circular(24.r)),
      ),
    );
  }
}
