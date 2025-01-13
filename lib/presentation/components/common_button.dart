import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

Widget commonButton(String title,
    {Color color = AppColor.primaryColor,
    Color textColor = Colors.white,
    double textSize = 18,
    double width = double.infinity,
    double borderRadious = 20.0,
    double height = 50,
    double padding = 10,
    double margin = 20,
    bool isBold = true,
    VoidCallback? onTap,
    bool isLoading = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
        color: color,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: commonText(title,
                      size: textSize, color: textColor, isBold: isBold),
                ),
        ),
      ),
    ),
  );
}

Widget commonBorderButton(String title,
    {double width = double.infinity,
    VoidCallback? onTap,
    Color borderColor = AppColor.primaryColor,
    double borderWidth = 1.0}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: commonText(title,
            size: 18, color: AppColor.primaryColor, isBold: true),
      ),
    ),
  );
}

Widget commonIconButton(String title, Widget icon,
    {Color color = AppColor.primaryColor,
    bool isRight = false,
    Color textColor = Colors.white,
    double textSize = 15,
    double width = double.infinity,
    double height = 50,
    bool isBold = true,
    VoidCallback? onTap,
    bool isLoading = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: color,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isRight) icon,
                    if (!isRight)
                      const SizedBox(
                        width: 5,
                      ),
                    commonText(title,
                        size: textSize, color: textColor, isBold: isBold),
                    if (isRight)
                      const SizedBox(
                        width: 5,
                      ),
                    if (isRight) icon
                  ],
                ),
        ),
      ),
    ),
  );
}
