import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../singletons/app_router.dart';
import '../singletons/user_info_client.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AsyncHomeState();
}

class _AsyncHomeState extends State<HomeWidget> {
  late Future<String> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = UserInfoClient().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム')),
      body: FutureBuilder<String>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // future 呼び出し時にトークンが切れた場合、top 画面に戻り、認可コードフローを開始する
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.replace('/');
            });
            return Center();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Text(
            'こんにちは！ ${snapshot.data!} さん',
            style: const TextStyle(fontSize: 18),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logout(context),
        tooltip: 'ログアウト',
        child: const Icon(Icons.logout),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'bff_token');
    AppRouter().router.go('/');
  }
}
