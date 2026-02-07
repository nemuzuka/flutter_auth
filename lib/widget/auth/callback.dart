import 'package:flutter/material.dart';

import '../../singletons/bff_token_client.dart';

class CallbackWidget extends StatelessWidget {
  final String code;
  const CallbackWidget({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CallBack')),
        body: Center(
          child: FutureBuilder<String>(
            future: BffTokenClient().fetchData(code),
            builder: (context, snapshot) {
              // 1. 通信中の表示
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              // 2. エラー発生時の表示
              else if (snapshot.hasError) {
                return Text('エラーが発生しました: ${snapshot.error}');
              }
              // 3. データ取得完了後の表示
              else if (snapshot.hasData) {
                // TODO ページ遷移
                return Text('サーバーからの返答: ${snapshot.data}');
              }
              return const Text('データがありません');
            },
          )
        )
    );
  }
}
