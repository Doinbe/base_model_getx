
import 'package:base_model_getx/base/base_page_state.dart';
import 'package:get/get.dart';

abstract class BasePageLogic<S extends BasePageState> extends GetxController{

  /// BasePageState
  late S state;

  @override
  void onInit() {
    super.onInit();
    /// 保存 State
    state = getState();
  }

  /// 获取 State
  S getState();

  /// 返回事件
  void backPage(){
    Get.back();
  }

}