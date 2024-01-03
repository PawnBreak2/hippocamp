import 'package:go_router/go_router.dart';
import 'package:hippocapp/constants/navigation/routeNames.dart';
import 'package:hippocapp/constants/storage_keys.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/models/responses/posts_response_model.dart';
import 'package:hippocapp/pages/home/home_page.dart';
import 'package:hippocapp/pages/login/login_page.dart';
import 'package:hippocapp/pages/main_scaffold/main_scaffold.dart';
import 'package:hippocapp/pages/memo/memo.dart';
import 'package:hippocapp/pages/post_creation_and_update/post_creation_and_update_page.dart';
import 'package:hippocapp/pages/splash_page/splash_page.dart';
import 'package:hippocapp/storage/local_storage.dart';

// routes and redirection/page building logic is all in this class

class NavigationConfiguration {
  static final routes = GoRouter(
    debugLogDiagnostics: true,
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
      GoRoute(
        path: '/post-creation-and-update-page',
        name: routeMap[routeNames.postCreationAndUpdate],

        /// TODO: ottimizzare con riverpod?

        builder: (context, state) {
          if (state.extra.runtimeType == Post && state.extra != null) {
            return PostCreationAndUpdatePage.updatePost(
                post: state.extra as Post);
          } else if (state.extra.runtimeType == PostCategory &&
              state.extra != null) {
            return PostCreationAndUpdatePage.createNewPostWithCategory(
                category: state.extra as PostCategory);
          } else {
            throw Exception(
                'PostCreationAndUpdatePage: no extra data provided');
          }
        },
      ),
      GoRoute(
        path: '/memo-page',
        name: routeMap[routeNames.memoPage],
        builder: (context, state) => const MemoPage(),
      ),
    ],
  );
}
