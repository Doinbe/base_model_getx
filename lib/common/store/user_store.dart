import 'package:base_model_getx/common/routes/route_config.dart';
import 'package:base_model_getx/common/services/storage_service.dart';
import 'package:base_model_getx/values/storage.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;

  // 令牌 token
  String token = '';
  bool get hasToken => token.isNotEmpty;

  //登录用户信息
  // final _userDetails = Rx<UserInfoEntity?>(null);
  // UserInfoEntity? get userDetails => _userDetails.value;

  @override
  void onInit() {
    super.onInit();
    var userTokenOffline = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    if (userTokenOffline.isNotEmpty) {
      _isLogin.value = true;
      token = userTokenOffline;
    }
  }

  // 保存用户Token信息
  Future<void> saveUserToken(String userToken) async {
    _isLogin.value = true;
    token = userToken;
    StorageService.to.setString(STORAGE_USER_TOKEN_KEY, userToken);
  }

  // 注销
  Future<void> onLogout() async {
    if (_isLogin.value) {
      await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
      token = '';
      _isLogin.value = false;
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
