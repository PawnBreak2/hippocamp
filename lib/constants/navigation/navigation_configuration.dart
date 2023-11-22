import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/constants/storage_keys.dart';
import 'package:hippocamp/pages/home/home_page.dart';
import 'package:hippocamp/pages/login/login_page.dart';
import 'package:hippocamp/pages/main/main_scaffold.dart';
import 'package:hippocamp/pages/splash_page/splash_page.dart';
import 'package:hippocamp/storage/local_storage.dart';

// routes and redirection/page building logic is all in this class

class NavigationConfiguration {
  static final routes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: 'login-page',
          builder: (context, state) => const LoginPage(),
          redirect: (context, state) async {
            bool isLogged =
                await LocalStorage.readString(StorageKeys.isLogged) == "true";
            print('isLogged?');
            print(isLogged);
            if (isLogged) {
              return '/splash-screen';
            } else {
              return '/';
            }
          }),
      GoRoute(
        path: '/splash-screen',
        name: routeMap[routeNames.splashScreen],
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/home-page',
        name: routeMap[routeNames.home],
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/main-scaffold-page',
        name: routeMap[routeNames.mainScaffold],
        builder: (context, state) => const MainScaffold(),
      ),
    ],
  );
}
