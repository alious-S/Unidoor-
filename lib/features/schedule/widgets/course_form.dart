import 'package:flutter/material.dart';

import '../widgets/helpers.dart';
import '../../../core/colors.dart';

class CourseForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController roomController;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String selectedDay;
  final Future<void> Function(bool isStart) onPickTime;
  final void Function(String day) onDaySelected;
  final VoidCallback onSave;

  const CourseForm({
    required this.titleController,
    required this.roomController,
    required this.startTime,
    required this.endTime,
    required this.selectedDay,
    required this.onPickTime,
    required this.onDaySelected,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven'];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add_moderator,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Nouveau Cours',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Label('Nom du cours'),
          const SizedBox(height: 7),
          TextInputField(
            hint: 'Ex: Mathématiques',
            icon: Icons.book_outlined,
            controller: titleController,
          ),
          const SizedBox(height: 16),
          const Label('Salle'),
          const SizedBox(height: 7),
          TextInputField(
            hint: 'Ex: Amphi A, B204',
            icon: Icons.home_work_outlined,
            controller: roomController,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TimeFieldWidget(
                  label: 'Début',
                  time: startTime,
                  onTap: () => onPickTime(true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TimeFieldWidget(
                  label: 'Fin',
                  time: endTime,
                  onTap: () => onPickTime(false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Label('Jour(s)'),
          const SizedBox(height: 7),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: days.map((day) {
              final isSelected = selectedDay == day;
              return ChoiceChip(
                label: Text(day),
                selected: isSelected,
                onSelected: (v) {
                  if (v) onDaySelected(day);
                },
                selectedColor: AppColors.secondary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
                backgroundColor: const Color(0xFFF1F5F9),
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.check, size: 16),
            label: const Text("Enregistrer l'horaire"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
