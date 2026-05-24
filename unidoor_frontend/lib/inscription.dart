import 'package:flutter/material.dart';
import 'package:UNIDOOR_FRONTEND/acceuil.dart';
import 'package:UNIDOOR_FRONTEND/inscription.dart'; 


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerLogin.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.door_front_door, size: 60, color: Color(0xFF003366)),
                const SizedBox(height: 10),
                const Text(
                  "UniDoor",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
                ),
                const Text("L'accès intelligent, simplifié.", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 30),

                // EMAIL
                TextField(
                  controller: controllerLogin,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // PASSWORD
                TextField(
                  controller: controllerPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                // LOGIN BUTTON
                ElevatedButton(
                  onPressed: () {
                    // 🔒 Vérification simple
                    if (controllerLogin.text.isEmpty || controllerPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Veuillez remplir tous les champs"),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }

                    if ((controllerLogin.text == "3ii" && controllerPassword.text == "P@sser.3ii2025") ||
                        (controllerLogin.text == "admin" && controllerPassword.text == "Gestion@123.2025") ||
                        (controllerLogin.text == "gerant" && controllerPassword.text == "gestion.3ii@2025")) {
                      
                      // ✅ REDIRECTION DASHBOARD
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Projet()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login ou mot de passe incorrect"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0056D2),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Se connecter →",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔥 AJOUT : LIEN INSCRIPTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Pas de compte ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Inscription()),
                        );
                      },
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: Color(0xFF0056D2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}