import 'package:flutter/material.dart';
import 'package:recherche/historiques.dart';
import 'package:recherche/horaires.dart';

void main() => runApp(const Projet());

class Projet extends StatelessWidget {
  const Projet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'sans-serif'),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardContent(),
    Horaires(),
    Historiques(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 250,
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.door_sliding, color: Color(0xFF003366)),
                    SizedBox(width: 10),
                    Text(
                      "UniDoor\nAccess",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                _buildSidebarItem(Icons.dashboard, "Tableau de bord", 0),
                _buildSidebarItem(Icons.access_time, "Horaires", 1),
                _buildSidebarItem(Icons.history, "Historique", 2),
                const Spacer(),
              ],
            ),
          ),

          // MAIN CONTENT dynamique
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, int index) {
    final bool isActive = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFF1F5F9) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: isActive ? const Color(0xFF0056D2) : Colors.grey,
            ),
            title: Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF0056D2) : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "État des Salles",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
