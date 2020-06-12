import 'package:flutter/material.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChange;
  final Function onTap;

  const TextFieldWidget({
    Key key,
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText = false,
    this.onChange,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      obscureText: obscureText,
      style: TextStyle(
        color: AppColors.mediumBlue,
        fontSize: 14.0,
      ),
      cursorColor: AppColors.mediumBlue,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: AppColors.mediumBlue,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            suffixIconData,
            size: 18,
            color: AppColors.mediumBlue,
          ),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.mediumBlue),
        ),
        labelStyle: TextStyle(color: AppColors.mediumBlue),
        focusColor: AppColors.mediumBlue,
      ),
    );
  }
}
