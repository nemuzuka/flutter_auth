import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../singletons/bff_token_client.dart';

class CallbackWidget extends StatelessWidget {
  final String code;
  const CallbackWidget({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BffTokenClient().fetchData(code);
      if (!context.mounted) return;
      context.go('/');
    });

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
