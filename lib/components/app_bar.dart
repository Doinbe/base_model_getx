import 'package:base_model_getx/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 基础 AppBar
AppBar baseAppBar({
  Widget? title,
  Widget? leading,
  double? leadingWidth,
  bool centerTitle = true,
  List<Widget>? actions,
  PreferredSizeWidget? bottomTabBar,
  Color backgroundColor = AppColors.appBarBackgroundColor,
  Widget? flexibleSpace,
}) {
  return AppBar(
    backgroundColor: flexibleSpace == null ? backgroundColor : null,
    flexibleSpace: flexibleSpace,
    elevation: 0,
    title: title,
    centerTitle: centerTitle,
    leading: leading,
    leadingWidth: leadingWidth,
    actions: actions,
    bottom: bottomTabBar,
  );
}

/// 基础 AppBar
AppBar baseSpaceAppBar({
  Widget? title,
  Widget? leading,
  double? leadingWidth,
  bool centerTitle = true,
  List<Widget>? actions,
  PreferredSizeWidget? bottomTabBar,
  Color backgroundColor = AppColors.appBarBackgroundColor,
  Widget? flexibleSpace,
}) {
  return baseAppBar(
      title: title,
      leading: leading,
      centerTitle: centerTitle,
      actions: actions,
      bottomTabBar: bottomTabBar,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColors.primaryColor,
            AppColors.primaryColorLight,
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
      ));
}

/// 基础AppBarTitle
Widget baseAppBarTitle({
  required String title,
  double fontSize = 9,
  Color color = AppColors.appBarTitleLightColor,
}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: fontSize.sp,
      color: color,
    ),
  );
}

/// 基础 返回按钮
Widget baseBackButton({
  VoidCallback? onPressed,
  double iconSize = 10,
  Color color = AppColors.appBarTitleLightColor,
}) {
  return IconButton(
    icon: Icon(
      Icons.arrow_back_ios_rounded,
      color: color,
      size: iconSize.h,
    ),
    onPressed: onPressed,
  );
}

/// 基础 tab按钮
PreferredSizeWidget baseTabBar({
  required TabController controller,
  required List<Widget> tabs,
  bool? isScrollable,
  TabBarIndicatorSize? indicatorSize,
  Color? indicatorColor,
  Color? unselectedLabelColor,
  TextStyle? unselectedLabelStyle,
  Color? labelColor,
  TextStyle? labelStyle,
}) {
  return TabBar(
    controller: controller,
    tabs: tabs,
    isScrollable: isScrollable ?? false,
    indicatorSize: indicatorSize ?? TabBarIndicatorSize.label,
    indicatorColor: indicatorColor ?? AppColors.appBarTitleLightColor,
    unselectedLabelColor: unselectedLabelColor ?? AppColors.appBarTitleDarkColor,
    unselectedLabelStyle: unselectedLabelStyle ?? TextStyle(fontSize: 7.sp),
    labelColor: labelColor ?? AppColors.appBarTitleLightColor,
    labelStyle: labelStyle ?? TextStyle(fontSize: 7.sp),
  );
}

/// 透明背景 AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}
