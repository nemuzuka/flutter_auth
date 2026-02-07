import 'package:flutter/material.dart';
import 'package:flutter_auth/singletons/auth_parameter.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

/// 認可コードフローを開始する Widget.
class InitializeAuthorizationWidget extends StatelessWidget {
  const InitializeAuthorizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 画面が表示された（ビルドが完了した）タイミングで一度だけ実行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchURL(context);
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // 遷移するまでの待機表示
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    var authorizationEndpointUri = AuthParameter()
        .buildAuthorizationEndpointUri();
    final theme = Theme.of(context);
    try {
      await launchUrl(
        Uri.parse(authorizationEndpointUri),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: theme.primaryColor,
          ),
          shareState: CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: theme.primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // プラットフォームが対応していない場合などのハンドリング
      debugPrint(e.toString());
    }
  }
}
