import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TheOvensSecretApp());
}

class TheOvensSecretApp extends StatelessWidget {
  const TheOvensSecretApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Custom Cakes & Treats | The Ovens Secret - Baked with Love by Priya',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
