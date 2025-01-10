import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

Widget commonTextfield(TextEditingController controller,
    {String hintText = "",
    TextInputType keyboardType = TextInputType.text,
    String? assetIconPath,
    VoidCallback? onTap,
    bool isEnable = true,
    Color borderColor = Colors.grey,
    int maxLine = 1}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
    ),
    child: TextField(
      onTap: onTap,
      enabled: isEnable,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLine,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12.0),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: AppColor.black,
        ),
        border: InputBorder.none,
        prefixIcon: assetIconPath != null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(
                  AssetImage(assetIconPath),
                  size: 24.0,
                ),
              )
            : null,
      ),
    ),
  );
}

Widget commonTextfieldWithTitle(String title, TextEditingController controller,
    {FocusNode? focusNode,
    String hintText = "",
    bool isBold = false,
    bool issuffixIconVisible = false,
    Widget? suffinxIcon,
    bool readOnly = false,
    bool isPasswordVisible = false,
    enable,
    fontWeight,
    prifixIconWidget,
    titleColor = AppColor.black,
    textSize = 14.0,
    borderWidth = 2.0,
    changePasswordVisibility,
    String prefix = "",
    TextInputType keyboardType = TextInputType.text,
    String? assetIconPath,
    Color borderColor = Colors.grey,
    int maxLine = 1,
    String? Function(String?)? onValidate,
    Function(String?)? onFieldSubmit}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      commonText(title,
          size: textSize,
          isBold: isBold,
          color: titleColor,
          fontWeight: fontWeight),
      const SizedBox(
        height: 5,
      ),
      Card(
        elevation: 3,
        shadowColor: Colors.black,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            enabled: enable,
            focusNode: focusNode,
            validator: onValidate,
            onFieldSubmitted: onFieldSubmit,
            keyboardType: keyboardType,
            maxLines: maxLine,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12.0),
              hintText: hintText,
              fillColor: AppColor.white,
              filled: true,
              hintStyle: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              prefix: prefix.isEmpty ? null : commonText(prefix, size: 14),
              suffixIcon: (suffinxIcon != null)
                  ? suffinxIcon
                  : (issuffixIconVisible)
                      ? (!isPasswordVisible)
                          ? InkWell(
                              onTap: changePasswordVisibility,
                              child: const Icon(Icons.visibility))
                          : InkWell(
                              onTap: changePasswordVisibility,
                              child: const Icon(Icons.visibility_off_outlined))
                      : null,
              prefixIcon: assetIconPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage(assetIconPath),
                        size: 24.0,
                      ),
                    )
                  : (prifixIconWidget != null)
                      ? prifixIconWidget
                      : null,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget commonTextfieldWithTitleSideButton(
    String title, TextEditingController controller,
    {FocusNode? focusNode,
    String hintText = "",
    bool isBold = false,
    bool issuffixIconVisible = false,
    Widget? suffinxIcon,
    bool isPasswordVisible = false,
    enable,
    fontWeight,
    prifixIconWidget,
    titleColor = AppColor.black,
    textSize = 14.0,
    borderWidth = 2.0,
    changePasswordVisibility,
    String prefix = "",
    TextInputType keyboardType = TextInputType.text,
    String? assetIconPath,
    Color borderColor = Colors.grey,
    int maxLine = 1,
    String? Function(String?)? onValidate,
    Function(String?)? onFieldSubmit}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          commonText(title,
              size: textSize,
              isBold: isBold,
              color: titleColor,
              fontWeight: fontWeight),
          Container(
            decoration: BoxDecoration(
                color: AppColor.primaryColorLight,
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.locationPin,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  commonText("Select from map"),
                ],
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Card(
        elevation: 3,
        shadowColor: Colors.black,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: TextFormField(
            controller: controller,
            enabled: enable,
            focusNode: focusNode,
            validator: onValidate,
            onFieldSubmitted: onFieldSubmit,
            keyboardType: keyboardType,
            maxLines: maxLine,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12.0),
              hintText: hintText,
              fillColor: AppColor.white,
              filled: true,
              hintStyle: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              prefix: prefix.isEmpty ? null : commonText(prefix, size: 14),
              suffixIcon: (suffinxIcon != null)
                  ? suffinxIcon
                  : (issuffixIconVisible)
                      ? (!isPasswordVisible)
                          ? InkWell(
                              onTap: changePasswordVisibility,
                              child: const Icon(Icons.visibility))
                          : InkWell(
                              onTap: changePasswordVisibility,
                              child: const Icon(Icons.visibility_off_outlined))
                      : null,
              prefixIcon: assetIconPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage(assetIconPath),
                        size: 24.0,
                      ),
                    )
                  : (prifixIconWidget != null)
                      ? prifixIconWidget
                      : null,
            ),
          ),
        ),
      ),
    ],
  );
}
