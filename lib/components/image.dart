import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 缓存图片
Widget netImageCached(
  String url, {
  double width = 48,
  double height = 48,
  double radius = 6,
  EdgeInsetsGeometry? margin,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    height: height.h,
    width: width.w,
    imageBuilder: (context, imageProvider) => Container(
      height: height.h,
      width: width.w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius.r)),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
        ),
      ),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

/// 资源图片
Widget assetImage(
  String imageName, {
  double? width,
  double? height,
  Color? color,
  BoxFit? fit = BoxFit.fill,
}) {
  return Image.asset(
    'assets/images/$imageName',
    height: height,
    width: width,
    fit: fit,
    color: color,
  );
}
