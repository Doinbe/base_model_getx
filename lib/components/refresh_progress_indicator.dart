import 'package:base_model_getx/values/colors.dart';
import 'package:flutter/material.dart';

/// 列表刷新指示器
Widget buildRefreshIndicator() {
  return const SizedBox(
    width: 18.0,
    height: 18.0,
    child: CircularProgressIndicator(
      strokeWidth: 2.5,
      color: AppColors.primaryColor,
    ),
  );
}
