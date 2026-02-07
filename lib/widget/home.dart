import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../singletons/app_router.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム')),
      body: Center(child: Text('これが見えているということは、\nログイン成功しているということです')),
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
