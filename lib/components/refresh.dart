import 'package:base_model_getx/base/refresh_page_logic.dart';
import 'package:base_model_getx/base/refresh_page_state.dart';
import 'package:base_model_getx/components/unknown_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget buildRefreshWidget({
  required Widget child,
  VoidCallback? onRefresh,
  VoidCallback? onLoad,
  required RefreshController refreshController,
  bool enablePullUp = true,
  bool enablePullDown = true,
}) {
  return SmartRefresher(
    enablePullUp: enablePullUp,
    enablePullDown: enablePullDown,
    controller: refreshController,
    onRefresh: onRefresh,
    onLoading: onLoad,
    child: child,
  );
}

Widget buildRefreshLogicWidget<T,
    C extends RefreshPageLogic<T, RefreshPageState<T>>>({
  String? errIcon,
  String? errTip,
  String? errTapTitle,
  VoidCallback? onErrTap,
  required Widget Function(T item, int index) itemBuilder,
  Widget Function(T item, int index)? separatorBuilder,
  ScrollPhysics? physics,
  bool shrinkWrap = false,
  Axis scrollDirection = Axis.vertical,
  bool enablePullUp = true,
  bool enablePullDown = true,
  String? tag,
}) {
  C logic = Get.find(tag: tag);
  return GetBuilder<C>(
    tag: tag,
    id: logic.state.refreshId,
    builder: (logic) {
      return buildRefreshWidget(
        refreshController: logic.refreshController,
        onRefresh: logic.refreshData,
        onLoad: logic.loadMoreData,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        child: buildDataUnknownView(
          errIcon: errIcon,
          errTip: errTip,
          errTapTitle: errTapTitle,
          onErrTap: onErrTap,
          isUnknown: logic.state.data.isEmpty,
          child: buildListView<T>(
              data: logic.state.data,
              itemBuilder: itemBuilder,
              separatorBuilder: separatorBuilder,
              physics: physics,
              shrinkWrap: shrinkWrap,
              scrollDirection: scrollDirection),
        ),
      );
    },
  );
}

Widget buildListView<T>(
    {required Widget Function(T item, int index) itemBuilder,
    required List<T> data,
    Widget Function(T item, int index)? separatorBuilder,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical}) {
  return ListView.separated(
    cacheExtent: 700,
    itemCount: data.length,
    shrinkWrap: shrinkWrap,
    physics: physics,
    separatorBuilder: (context, index) => separatorBuilder?.call(data[index], index) ?? Container(),
    scrollDirection: scrollDirection,
    itemBuilder: (context, index) => itemBuilder.call(data[index], index),
  );
}
