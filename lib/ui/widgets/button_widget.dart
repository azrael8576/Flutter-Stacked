import 'package:flutter/material.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Function onTap;

  const ButtonWidget({Key key, this.title, this.hasBorder, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: hasBorder ? AppColors.white : AppColors.mediumBlue,
            borderRadius: BorderRadius.circular(10.0),
            border: hasBorder
                ? Border.all(color: AppColors.mediumBlue, width: 1.0)
                : Border.fromBorderSide(BorderSide.none),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 60.0,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: hasBorder ? AppColors.mediumBlue : AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
