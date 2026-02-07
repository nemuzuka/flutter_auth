import 'package:flutter/material.dart';

class CallbackWidget extends StatelessWidget {
  final String code;
  const CallbackWidget({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(child: Text('受け取ったCode: $code')),
    );
  }
}
