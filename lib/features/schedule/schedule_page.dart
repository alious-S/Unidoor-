import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../models/course.dart';
import 'widgets/sidebar.dart';
import 'widgets/course_form.dart';
import 'widgets/course_list.dart';
import 'widgets/helpers.dart';

class ScheduleManagementPage extends StatefulWidget {
  const ScheduleManagementPage({super.key});

  @override
  State<ScheduleManagementPage> createState() => _ScheduleManagementPageState();
}

class _ScheduleManagementPageState extends State<ScheduleManagementPage> {
  final List<Course> _courses = [
    Course(
      id: 1,
      title: 'Laboratoire Chimie',
      room: 'Salle C102',
      startTime: '08:30',
      endTime: '10:30',
      day: 'Mar',
      icon: Icons.science,
      accentColor: AppColors.primary,
    ),
    Course(
      id: 2,
      title: 'Algorithmique Avancée',
      room: 'Amphi Turing',
      startTime: '10:45',
      endTime: '12:45',
      day: 'Mar',
      icon: Icons.code,
      accentColor: AppColors.success,
    ),
    Course(
      id: 3,
      title: 'Littérature Contemporaine',
      room: 'Salle L201',
      startTime: '14:00',
      endTime: '16:00',
      day: 'Mar',
      icon: Icons.book,
      accentColor: AppColors.indigo,
    ),
  ];

  int _nextId = 4;
  String _selectedDay = 'Mar';
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  final _titleController = TextEditingController();
  final _roomController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          backgroundColor: isError ? AppColors.danger : AppColors.success,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }

  void _saveSchedule() {
    final title = _titleController.text.trim();
    final room = _roomController.text.trim();

    if (title.isEmpty || room.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs.', isError: true);
      return;
    }

    final startDouble = _startTime.hour + _startTime.minute / 60.0;
    final endDouble = _endTime.hour + _endTime.minute / 60.0;

    if (startDouble >= endDouble) {
      _showSnackBar("L'heure de fin doit être après le début.", isError: true);
      return;
    }

    setState(() {
      _courses.add(
        Course(
          id: _nextId++,
          title: title,
          room: room,
          startTime: _startTime.format(context),
          endTime: _endTime.format(context),
          day: _selectedDay,
          icon: guessIcon(title),
          accentColor: AppColors
              .accentCycle[_courses.length % AppColors.accentCycle.length],
        ),
      );
    });

    _showSnackBar('Horaire enregistré avec succès !');
    _titleController.clear();
    _roomController.clear();
  }

  void _deleteCourse(int id) {
    setState(() => _courses.removeWhere((c) => c.id == id));
    _showSnackBar('Cours supprimé avec succès.', isError: true);
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() => isStart ? _startTime = picked : _endTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          return Row(
            children: [
              if (isDesktop) const Sidebar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 40 : 20,
                    vertical: 36,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PageHeader(),
                      const SizedBox(height: 32),
                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 320,
                              child: CourseForm(
                                titleController: _titleController,
                                roomController: _roomController,
                                startTime: _startTime,
                                endTime: _endTime,
                                selectedDay: _selectedDay,
                                onPickTime: _pickTime,
                                onDaySelected: (d) =>
                                    setState(() => _selectedDay = d),
                                onSave: _saveSchedule,
                              ),
                            ),
                            const SizedBox(width: 28),
                            Expanded(
                              child: CourseList(
                                courses: _courses,
                                onDelete: _deleteCourse,
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            CourseForm(
                              titleController: _titleController,
                              roomController: _roomController,
                              startTime: _startTime,
                              endTime: _endTime,
                              selectedDay: _selectedDay,
                              onPickTime: _pickTime,
                              onDaySelected: (d) =>
                                  setState(() => _selectedDay = d),
                              onSave: _saveSchedule,
                            ),
                            const SizedBox(height: 28),
                            CourseList(
                              courses: _courses,
                              onDelete: _deleteCourse,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
