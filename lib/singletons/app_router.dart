import 'package:go_router/go_router.dart';

import '../main.dart';
import '../widget/auth/callback.dart';

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
          return MyHomePage(title: 'Home');
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
  );
}
