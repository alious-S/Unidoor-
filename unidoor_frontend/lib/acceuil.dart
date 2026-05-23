import 'package:flutter/material.dart';
import 'package:UNIDOOR_FRONTEND/historiques.dart';
import 'package:UNIDOOR_FRONTEND/horaires.dart';

void main() => runApp(const Acceuil());

class Acceuil extends StatelessWidget {
  const Acceuil({super.key});

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

// ✅ CONTENU DU DASHBOARD (séparé pour navigation interne)
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildTopCards(),
          const SizedBox(height: 40),
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

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bonjour",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            Text(
              "Voici l'état actuel de vos salles assignées.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Icon(Icons.search, color: Colors.grey),
      ],
    );
  }

  Widget _buildTopCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SALLES ACTIVES",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "4 / 12",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 10),
                Chip(
                  label: Text("Accès fluides"),
                  backgroundColor: Color(0xFFDCFCE7),
                  labelStyle: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF003366),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "PROCHAIN COURS",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Mathématiques Avancées",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Salle C • Dans 15 min",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.vpn_key_outlined, size: 18),
                  label: const Text("Pré-déverrouiller"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
