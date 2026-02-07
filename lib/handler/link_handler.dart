import 'package:app_links/app_links.dart';
import 'package:flutter_auth/singletons/app_router.dart';

class LinkHandler {
  final _appLinks = AppLinks();

  void initDeepLinks() async {
    // 1. アプリが完全に終了していた状態からの起動（Initial Link）
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleUri(initialLink);
    }

    // 2. アプリがバックグラウンドにいた状態での検知（Stream）
    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    final path = uri.path;
    final params = uri.queryParameters;

    if (path == '/auth-callback') {
      final code = params['code'];
      AppRouter().router.push('/auth-callback?code=$code');
    }
  }
}
