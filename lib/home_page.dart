import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';
import 'booking_page.dart';

class HomePage extends StatefulWidget {
  final String nama;
  final String posisi;
  final String nim;
  final String kelas;

  const HomePage({
    super.key,
    required this.nama,
    required this.posisi,
    required this.nim,
    required this.kelas,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> dataResi = [];

  void tambahData(Map<String, dynamic> data) {
    setState(() {
      dataResi.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        dataResi: dataResi,
        onAdd: tambahData,
        nama: widget.nama, // ✅ Tambahkan
        posisi: widget.posisi, // ✅ Tambahkan
        nim: widget.nim, // ✅ Tambahkan
        kelas: widget.kelas, // ✅ Tambahkan
      ),
      ProfilePage(
        nama: widget.nama,
        posisi: widget.posisi,
        nim: widget.nim,
        kelas: widget.kelas,
        dataResi: dataResi,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("LION EXPRESS")),

      drawer: Drawer(
        child: Column(
          children: [
            // HEADER USER
            UserAccountsDrawerHeader(
              accountName: Text(widget.nama),
              accountEmail: Text(widget.posisi),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/Husain.jpeg'),
              ),
            ),

            // MENU
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.add_box),
              title: Text("Booking"),
              onTap: () async {
                Navigator.pop(context);

                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookingPage()),
                );

                if (result != null) {
                  tambahData(result);
                }
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),

      body: pages[selectedIndex],
    );
  }
}
