import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final Color? cursorColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final Color? hintColor;
  final bool? filled;
  final TextInputType? keyboardType;
  final bool obscureText;
  final InputBorder? border;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? prefixText;
  final String? hintText;
  final AutovalidateMode? autoValidateMode;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final bool? enabled;
  final int? maxLines;
  final Key? textFieldKey;
  final Function()? onVisibilityIconTap;
  final TextAlign textAlign;

  const TextFormFieldWidget({
    Key? key,
    this.cursorColor = AppColors.green,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.keyboardType,
    this.obscureText = false,
    this.border,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.onChanged,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.prefixText,
    this.isPassword = false,
    this.inputFormatters,
    this.textInputAction,
    this.prefixIcon,
    this.enabled,
    this.maxLines = 1,
    this.hintText,
    this.textFieldKey,
    this.onVisibilityIconTap,
    this.fillColor,
    this.filled,
    this.hintColor,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFieldKey,
      textAlign: textAlign,
      controller: controller,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      onChanged: onChanged,
      autovalidateMode: autoValidateMode,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      expands: false,
      decoration: InputDecoration(
        border: border,
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w400,
          color: hintColor,
        ),
        suffixIcon: isPassword
            ? InkWell(
                onTap: onVisibilityIconTap,
                child: obscureText
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(Icons.visibility_off_outlined))
            : suffixIcon,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        isCollapsed: false,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.green, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
