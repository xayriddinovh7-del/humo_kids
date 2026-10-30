import 'package:flutter/material.dart';
import 'package:humo_kids/core/theme/app_theme.dart';
import 'package:humo_kids/features/onboarding/screens/welcome_screen.dart';

class HumoKidsApp extends StatelessWidget {
  const HumoKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Humo Kids',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}
