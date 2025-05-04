import 'package:flutter/material.dart';
import 'package:hnest/helpers/auto_theme.dart';
import 'package:hnest/pages/home_page.dart';
import 'package:hnest/pages/login_page.dart';

import 'helpers/app_theme.dart';

void main() {
  runApp(const HNestServerPanel());
}

class HNestServerPanel extends StatelessWidget {
  const HNestServerPanel({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AutoTheme.appName,
      theme: globalTheme.theme,
      home: const LoginScreen(),
    );
  }
}
