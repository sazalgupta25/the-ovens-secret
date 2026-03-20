import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Sign in anonymously to secure Firestore writes
  await FirebaseAuth.instance.signInAnonymously();
  
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
