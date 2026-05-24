import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.primary],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lock_open,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UniDoor Access',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.secondary,
                      ),
                    ),
                    Text(
                      "Gestionnaire d'accès",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Nav
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: const [
                  NavItem(Icons.dashboard_outlined, 'Tableau de bord', false),
                  NavItem(Icons.access_time, 'Horaires', true),
                  NavItem(Icons.history, 'Historique', false),
                ],
              ),
            ),
          ),
          // User
          const SidebarFooter(),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const NavItem(this.icon, this.label, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    const activeColor = AppColors.primary;
    const inactiveColor = AppColors.textSecondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F0FE) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isActive
            ? const Border(left: BorderSide(color: activeColor, width: 3))
            : null,
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: isActive ? activeColor : inactiveColor),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? activeColor : inactiveColor,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class SidebarFooter extends StatelessWidget {
  const SidebarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary,
            child: Text(
              'AD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                'admin@unidoor.fr',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
