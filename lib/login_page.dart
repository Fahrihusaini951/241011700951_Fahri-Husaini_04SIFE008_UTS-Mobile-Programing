import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nama = TextEditingController();
  final password = TextEditingController();
  final nim = TextEditingController();
  final kelas = TextEditingController();

  String posisi = "Admin";

  void login() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Apakah anda yakin ingin login?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Tidak"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(
                    nama: nama.text,
                    posisi: posisi,
                    nim: nim.text,
                    kelas: kelas.text,
                  ),
                ),
              );
            },
            child: Text("Ya"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Lio.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // BLUR EFFECT
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withValues(alpha: 0.2)),
          ),

          Center(
            child: SingleChildScrollView(
              // Agar tidak overflow saat keyboard muncul
              child: Container(
                width: 320,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    139,
                    134,
                    134,
                  ).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_shipping, size: 50, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      "Login Akun",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // INPUT NAMA
                    _buildTextField(nama, "Nama", Icons.person),
                    SizedBox(height: 10),

                    // INPUT PASSWORD
                    _buildTextField(
                      password,
                      "Password",
                      Icons.lock,
                      obscure: true,
                    ),
                    SizedBox(height: 10),

                    //  INPUT NIM
                    _buildTextField(nim, "NIM", Icons.badge),
                    SizedBox(height: 10),

                    //  INPUT KELAS
                    _buildTextField(kelas, "Kelas", Icons.class_),
                    SizedBox(height: 10),

                    // DROPDOWN POSISI
                    DropdownButtonFormField<String>(
                      initialValue: posisi,
                      dropdownColor: Colors.black87,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Posisi",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      items: ["Admin", "Staff"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => posisi = value!);
                      },
                    ),
                    SizedBox(height: 20),

                    // BUTTON LOGIN
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color.fromARGB(255, 250, 1, 1),
                        ),
                        child: Text("Login", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  Widget helper agar tidak repetitif
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
