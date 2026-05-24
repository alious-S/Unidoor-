import 'package:flutter/material.dart' hide Badge ;

import '../../../core/colors.dart';
import '../../../models/course.dart';
import 'helpers.dart';

class CourseList extends StatelessWidget {
  final List<Course> courses;
  final void Function(int id) onDelete;

  const CourseList({required this.courses, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Cours Actifs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Badge('${courses.length}'),
                ],
              ),
              Row(
                children: const [
                  IconBtn(Icons.sort),
                  SizedBox(width: 4),
                  IconBtn(Icons.filter_alt_outlined),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (courses.isEmpty)
            const EmptyState()
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (_, i) => CourseCardWidget(
                course: courses[i],
                onDelete: () => onDelete(courses[i].id),
              ),
            ),
          if (courses.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFFCBD5E1),
                    size: 28,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Fin de la liste pour aujourd'hui",
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CourseCardWidget extends StatelessWidget {
  final Course course;
  final VoidCallback onDelete;

  const CourseCardWidget({
    required this.course,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Accent bar
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: course.accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                course.icon,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.meeting_room_outlined,
                          size: 13,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          course.room,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.access_time,
                          size: 13,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${course.day} • ${course.startTime} - ${course.endTime}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.textMuted),
              onSelected: (value) {
                if (value == 'delete') onDelete();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: AppColors.danger,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Supprimer',
                        style: TextStyle(color: AppColors.danger),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
