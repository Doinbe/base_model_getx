import 'package:base_model_getx/base/base_page_state.dart';

class RefreshPageState<T> extends BasePageState{
  /// 进入页面刷新数据
  bool initialRefresh = true;
  /// 分页的页数
  int pageIndex = 1;
  /// 单页数量
  int pageSize = 10;
  ///是否还有更多数据
  bool hasMore = true;

  /// 用于列表刷新的id
  Object refreshId = Object();

  /// 列表数据
  List<T> data = <T>[];

}