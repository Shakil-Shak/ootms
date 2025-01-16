import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ootms/core/constants/color/app_color.dart';


enum ImageType { png, svg, network }

class CommonImage extends StatelessWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double height;
  final double width;
  final double borderRadius;
  final double? size;
  final ImageType imageType;
  final BoxFit fill;

  CommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height = 24,
    this.borderRadius = 10,
    this.width = 24,
    this.size,
    this.imageType = ImageType.svg,
    this.fill = BoxFit.fill,
    this.defaultImage = "assets/icons/profile_icon_2.png",
    super.key,
  });

  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.svg) {
      imageWidget = SvgPicture.asset(
        imageSrc,
        // ignore: deprecated_member_use
        color: imageColor,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
      );
    }

    if (imageType == ImageType.png) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          imageSrc,
          color: imageColor,
          height: size ?? height,
          width: size ?? width,
          fit: fill,
          errorBuilder: (context, error, stackTrace) {
            if (kDebugMode) {
              print("imageError : $error");
            }
            return Image.asset(defaultImage);
          },
        ),
      );
    }

    if (imageType == ImageType.network) {
      imageWidget = CachedNetworkImage(
        height: size ?? height,
        width: size?? width,
        // imageUrl: "${AppUrls.imageUrl}/$imageSrc"
        imageUrl: imageSrc,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(value: downloadProgress.progress,color: AppColor.primaryColor)),
        errorWidget: (context, url, error) {
          if (kDebugMode) {
            print(error);
          }
          return Image.asset(
            defaultImage,
            color: Colors.grey,
          );
        },
      );
    }

    return SizedBox(
        height: size ?? height,
        width: size ?? width,
        child: imageWidget);
  }
}
