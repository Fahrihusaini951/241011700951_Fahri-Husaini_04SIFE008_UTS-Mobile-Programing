import 'package:flutter/material.dart';
import 'package:project_uts_mobile_programing_fahri_husaini/booking_page.dart';
import 'tracking_page.dart';
import 'scan_page.dart';
import 'profile_page.dart';
import 'booking_list_page.dart';

class DashboardPage extends StatefulWidget {
  final List<Map<String, dynamic>> dataResi;
  final Function(Map<String, dynamic>) onAdd;

  final String nama;
  final String posisi;
  final String nim;
  final String kelas;

  const DashboardPage({
    super.key,
    required this.dataResi,
    required this.onAdd,
    required this.nama,
    required this.posisi,
    required this.nim,
    required this.kelas,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // FILTER SEARCH
    List filtered = widget.dataResi.where((e) {
      return e['resi'].toLowerCase().contains(search.text.toLowerCase()) ||
          e['kota'].toLowerCase().contains(search.text.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        // ✅ Title + Tombol Profile & List Bookingan
        title: Row(
          children: [
            Text("Dashboard"),
            SizedBox(width: 10),
            // ✅ Tombol Profile
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(
                      nama: widget.nama,
                      posisi: widget.posisi,
                      nim: widget.nim,
                      kelas: widget.kelas,
                      dataResi: widget.dataResi,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.person, size: 16, color: Colors.white),
              label: Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(width: 5),
            // ✅ Tombol List Bookingan
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingListPage(dataResi: widget.dataResi),
                  ),
                );
              },
              icon: Icon(Icons.list, size: 16, color: Colors.white),
              label: Text(
                "Bookingan",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScanPage(
                    onScan: (hasilResi) {
                      var found = widget.dataResi.firstWhere(
                        (e) => e['resi'] == hasilResi,
                        orElse: () => {},
                      );

                      if (found.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TrackingPage(data: found),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Resi tidak ditemukan")),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookingPage()),
          );

          if (result != null) {
            widget.onAdd(result);
            setState(() {});
          }
        },
        icon: Icon(Icons.add),
        label: Text("Tambah Booking"),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // SEARCH
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                  labelText: "Cari No Resi / Kota",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) {
                  setState(() {});
                },
              ),
            ),

            // CARD SUMMARY
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  buildCard(
                    "Resi",
                    widget.dataResi.length.toString(),
                    Colors.blue,
                  ),
                  buildCard("Pcs", totalPcs().toString(), Colors.green),
                  buildCard("Kg", totalKg().toString(), Colors.orange),
                ],
              ),
            ),

            // TABLE
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: const Color.fromARGB(255, 77, 247, 58),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Resi Kiriman Paket",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("No Resi")),
                          DataColumn(label: Text("Kota")),
                          DataColumn(label: Text("Pcs")),
                          DataColumn(label: Text("Kg")),
                          DataColumn(label: Text("Aksi")),
                        ],
                        rows: filtered.map((e) {
                          return DataRow(
                            cells: [
                              DataCell(Text(e['resi'])),
                              DataCell(Text(e['kota'])),
                              DataCell(Text(e['pcs'])),
                              DataCell(Text(e['kg'])),
                              DataCell(
                                ElevatedButton(
                                  child: Text("Track"),
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TrackingPage(data: e),
                                      ),
                                    );

                                    if (result != null) {
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontSize: 22, color: Colors.white)),
              Text(title, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  int totalPcs() {
    int total = 0;
    for (var d in widget.dataResi) {
      total += int.parse(d['pcs'] ?? '0');
    }
    return total;
  }

  double totalKg() {
    double total = 0;
    for (var d in widget.dataResi) {
      total += double.parse(d['kg'] ?? '0');
    }
    return total;
  }
}
