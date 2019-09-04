import 'package:ving/provider/view_state_model.dart';
import 'package:ving/provider/view_state.dart';
import 'package:ving/service/wan_android_repository.dart';

class RegisterModel extends ViewStateModel {

  Future<bool> singUp(loginName, password, rePassword) async {
    setBusy(true);
    try {
      await WanAndroidRepository.register(loginName, password, rePassword);
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }
}
