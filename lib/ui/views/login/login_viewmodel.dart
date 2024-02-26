import 'package:google_docs/app/app.locator.dart';
import 'package:google_docs/app/app.logger.dart';
import 'package:google_docs/app/app.router.dart';
import 'package:google_docs/services/google_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final logger = getLogger('LoginViewModel');
  final googleService = locator<GoogleService>();
  final navigationService = NavigationService();

  LoginViewModel() {
    getUserData();
  }

  Future<void> signInWithGoogle() async {
    var resp = await googleService.signInWithGoogle();
    if (resp!.error == null) {
      setToken(resp.data.token);
      navigationService.navigateToHomescreenView();
    }
  }

  Future<void> getUserData() async {
    logger.d('getUserData - started');
    var resp = await googleService.getUserData(await getToken());
    if (resp!.error == null) {
      navigationService.navigateToHomescreenView();
    }
  }

  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
    return token;
  }
}
