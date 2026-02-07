import 'package:flutter/material.dart';
import 'package:flutter_auth/singletons/app_router.dart';

import 'handler/link_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final handler = LinkHandler();
  handler.initDeepLinks();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      title: 'flutter auth',
    );
  }
}
