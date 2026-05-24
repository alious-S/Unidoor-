import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF0056D2);
  static const secondary = Color(0xFF003366);
  static const success = Color(0xFF10B981);
  static const danger = Color(0xFFEF4444);
  static const indigo = Color(0xFF6366F1);
  static const border = Color(0xFFE2E8F0);
  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);
  static const surface = Color(0xFFF8FAFC);
  static const background = Color(0xFFF0F4F9);

  static const List<Color> accentCycle = [primary, success, indigo];
}
