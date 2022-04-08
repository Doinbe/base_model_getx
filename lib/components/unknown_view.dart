import 'package:base_model_getx/components/image.dart';
import 'package:base_model_getx/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDataUnknownView({
  String? errIcon,
  String? errTip,
  String? errTapTitle,
  VoidCallback? onErrTap,
  required bool isUnknown,
  required Widget child,
}) {
  return isUnknown
      ? UnknownView(
          iconName: errIcon ?? 'err_unknown_content.png',
          tipContent: errTip ?? '暂无内容',
          tapTitle: errTapTitle ?? '重新加载',
          onTap: onErrTap,
        )
      : child;
}

class UnknownView extends StatelessWidget {
  final String iconName;
  final String tipContent;
  final String tapTitle;
  final VoidCallback? onTap;

  const UnknownView(
      {Key? key,
      this.iconName = 'err_unknown_content.png',
      this.tipContent = '暂无内容',
      this.tapTitle = '重新加载',
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        assetImage(
          iconName,
          width: 60.w,
          height:60.w,
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: 85.w,
          alignment: Alignment.center,
          child: Text(
            tipContent,
            style: TextStyle(fontSize: 7.5.sp, color: AppColors.textMainColor),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onTap == null
            ? Container()
            : Container(
                height: 18.h,
                margin: EdgeInsets.only(top: 15.h),
                child: TextButton(
                  onPressed: onTap,
                  child: Text(
                    tapTitle,
                    style: TextStyle(
                      fontSize: 7.sp,
                      color: AppColors.color_FFFFFF,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 8.w)),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
