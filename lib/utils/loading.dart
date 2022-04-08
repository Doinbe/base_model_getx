import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class Loading {
  Loading() {
    SmartDialog.config
      ..alignment = Alignment.center
      ..isPenetrate = false
      ..clickBgDismiss = true
      ..maskColor = Colors.black.withOpacity(0.35)
      ..maskWidget = null
      ..animationDuration = const Duration(milliseconds: 260)
      ..isUseAnimation = true
      ..isLoading = true
      ..debounce = false
      ..debounceTime = const Duration(milliseconds: 300);
  }

  static void show([String? text]) {
    SmartDialog.showLoading(msg: text ?? 'loading...', maskColorTemp: Colors.transparent);
  }

  static void toast(String text,{int milliseconds = 2000}) {
    if(text.isNotEmpty){
      SmartDialog.showToast(text, time: Duration(milliseconds: milliseconds));
    }
  }

  static void dismiss() {
    SmartDialog.dismiss();
  }
}
