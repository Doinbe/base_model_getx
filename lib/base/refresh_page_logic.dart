
import 'package:base_model_getx/base/base_page_logic.dart';
import 'package:base_model_getx/base/refresh_page_state.dart';
import 'package:base_model_getx/entity/base/base_page_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class RefreshPageLogic<M,S extends RefreshPageState<M>> extends BasePageLogic<S>{

  /// 刷新控件的 Controller
  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    /// 保存 State
    refreshController =  RefreshController(initialRefresh: state.initialRefresh);
  }

  @override
  void onReady() {
    super.onReady();
    /// 进入页面刷新数据
    // if(state.initialRefresh) refreshData();
  }

  /// 刷新数据
  void refreshData() async{
    initPaging();
    await _loadData().then((response) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((e) {
      print('数据加载失败：$e');
      refreshController.refreshFailed();
    });
  }

  ///初始化分页数据
  void initPaging() {
    state.pageIndex = 1;
    state.hasMore = true;
    state.data.clear();
  }

  /// 数据加载
  Future<List<M>?> _loadData() async {
    Map<String, dynamic> params = {
      'pageNumber': state.pageIndex,
      'pageSize': state.pageSize,
    };
    BasePageResponseData<M>? data = await loadData(params);
    List<M>? list = data?.records;

    /// 数据不为空，则将数据添加到 data 中
    /// 并且分页页数 pageIndex + 1
    if (list != null && list.isNotEmpty) {
      state.data.addAll(list);
      state.pageIndex += 1;
    }

    /// 判断是否有更多数据
    state.hasMore = state.data.length < (data?.total ?? 0);

    /// 更新界面
    update([state.refreshId]);
    return list;
  }


  /// 加载更多
  void loadMoreData() async{
    if(!state.hasMore){
      refreshController.loadNoData();
      return;
    }
    await _loadData().then((response) {
      refreshController.loadComplete();
    }).catchError((_) {
      refreshController.loadFailed();
    });
  }

  /// 最终加载数据的方法
  Future<BasePageResponseData<M>?> loadData(Map<String, dynamic> params);

}