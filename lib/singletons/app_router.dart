import 'package:flutter_auth/widget/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../widget/auth/callback.dart';
import '../widget/auth/initialize_authorization.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return HomeWidget();
        },
      ),
      GoRoute(
        path: '/initialize-authorization',
        builder: (context, state) {
          return InitializeAuthorizationWidget();
        },
      ),
      GoRoute(
        path: '/auth-callback',
        builder: (context, state) {
          final code = state.uri.queryParameters['code'] ?? 'invalid code';
          return CallbackWidget(code: code);
        },
      ),
    ],
    redirect: (context, state) async {
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'bff_token');
      final bool isLoggedIn = token != null;

      final bool isLoggingIn = state.matchedLocation == '/initialize-authorization';
      final bool isAuthCallback = state.matchedLocation == '/auth-callback';

      // ログインしていなくて、かつ今ログイン画面にいないなら、ログイン画面へ
      if (!isLoggedIn && !isLoggingIn && !isAuthCallback) {
        return '/initialize-authorization';
      }

      // ログイン済みで、ログイン画面にアクセスしようとしたらトップへ
      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      // 問題なければそのまま表示
      return null;
    }
  );
}
