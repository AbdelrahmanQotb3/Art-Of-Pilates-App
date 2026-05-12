import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String hint;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final Color? backGroundColor;
  final Widget? prefixIcon;
  final InputDecoration? decoration;

  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    required this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
    this.backGroundColor,
    this.prefixIcon,
    this.decoration,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: c, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: const TextStyle(color: AppColors.blackColor),
      obscureText: _obscure,
      validator: widget.validator,
      cursorColor: AppColors.blackColor,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: widget.decoration ?? InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: widget.backGroundColor ?? AppColors.whiteColor,
        // ignore: deprecated_member_use
        hoverColor: (widget.backGroundColor ?? AppColors.whiteColor)
            // ignore: deprecated_member_use
            .withOpacity(0.8),
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.blackColor),
        labelStyle: const TextStyle(fontSize: 16, color: AppColors.blackColor),
        border: _border(AppColors.blackColor),
        enabledBorder: _border(AppColors.blackColor),
        focusedBorder: _border(AppColors.blackColor),
        errorBorder: _border(AppColors.redColor),
        focusedErrorBorder: _border(AppColors.redColor),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscure = !_obscure),
                color: AppColors.blackColor,
              )
            : null,
      ),
    );
  }
}
