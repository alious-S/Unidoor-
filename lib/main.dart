import 'package:flutter/material.dart';
import 'features/schedule/schedule_page.dart';
import 'core/colors.dart';

void main() => runApp(const UniDoorApp());

class UniDoorApp extends StatelessWidget {
  const UniDoorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniDoor Access',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'DM Sans',
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      home: const ScheduleManagementPage(),
    );
  }
}
