import 'package:flutter/material.dart';
import 'package:project_one/pages/home_page.dart';
import 'package:project_one/theme/theme.dart';

void main(List<String> args) {
  runApp(
    const ProjectOne(),
  );
}

class ProjectOne extends StatelessWidget {
  const ProjectOne({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
