import 'package:flutter/material.dart';
import 'package:base_model_getx/extend/func_ext.dart';

enum ClickType {
  none,
  ///节流
  throttle,
  ///指定时间节流
  throttleWithTimeout,
  ///防抖
  debounce
}

///点击组件封装
class ClickWidget extends StatelessWidget {
  final Widget child;
  final Function? onTap;
  final ClickType type;
  final int? timeout;

  const ClickWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.type = ClickType.throttle,
      this.timeout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: child,
      onTap: _getOnTap(),
    );
  }

  VoidCallback? _getOnTap() {
    if (type == ClickType.throttle) {
      return onTap?.throttle();
    } else if (type == ClickType.throttleWithTimeout) {
      return onTap?.throttleWithTimeout(timeout: timeout);
    }else if (type == ClickType.debounce) {
      return onTap?.debounce(timeout: timeout);
    }
    return () => onTap?.call();
  }
}
