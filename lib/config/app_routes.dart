import 'package:interiordesign_mobile/pages/Authentication/views/login_view.dart';
import 'package:interiordesign_mobile/screens/home.dart';

class AppRoutes {
  static final pages = {
    login: (context) => LoginView(),
    home: (context) => Home(),
  };

  static const login = '/';
  static const main = '/main';
  static const home = '/home';
}
