import 'package:flutter/material.dart';
import '../core/colors.dart';

class Course {
  final int id;
  final String title;
  final String room;
  final String startTime;
  final String endTime;
  final String day;
  final IconData icon;
  final Color accentColor;

  const Course({
    required this.id,
    required this.title,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.icon,
    required this.accentColor,
  });

  Course copyWith({
    String? title,
    String? room,
    String? startTime,
    String? endTime,
    String? day,
  }) => Course(
    id: id,
    title: title ?? this.title,
    room: room ?? this.room,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    day: day ?? this.day,
    icon: icon,
    accentColor: accentColor,
  );
}

IconData guessIcon(String title) {
  final t = title.toLowerCase();
  if (t.contains('chim') || t.contains('lab')) return Icons.science;
  if (t.contains('algo') || t.contains('info') || t.contains('prog'))
    return Icons.code;
  if (t.contains('lit') || t.contains('hist') || t.contains('philo'))
    return Icons.book;
  return Icons.info_outline;
}
