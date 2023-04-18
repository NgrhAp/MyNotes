import '../helpers/user_info.dart';

class LoginService {
  Future<bool> login(String username, String password) async {
    bool isLogin = false;
    if (username == 'admin' && password == 'admin') {
      await UserInfo().setToken("admin");
      await UserInfo().setUserID("1");
      await UserInfo().setUsername("admin");
      isLogin = true;
    }
    if (username == 'ngurah' && password == 'ngurah') {
      await UserInfo().setToken("ngurah");
      await UserInfo().setUserID("1");
      await UserInfo().setUsername("ngurah");
      isLogin = true;
    }
    return isLogin;
  }
}
