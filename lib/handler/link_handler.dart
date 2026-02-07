import 'package:app_links/app_links.dart';

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
    print('--- リンク検知成功！ ---');
    // 例: my-app://example?id=123&name=flutter
    print('Path: ${uri.path}');

    // クエリパラメータを Map 形式で取得
    Map<String, String> params = uri.queryParameters;
    print('ID: ${params['id']}'); // "123"
    print('Name: ${params['name']}'); // "flutter"
  }
}
