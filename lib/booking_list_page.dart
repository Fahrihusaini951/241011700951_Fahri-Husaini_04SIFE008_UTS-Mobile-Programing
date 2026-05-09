import 'package:flutter/material.dart';
import 'tracking_page.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BookingListPage extends StatefulWidget {
  final List<Map<String, dynamic>> dataResi;

  const BookingListPage({super.key, required this.dataResi});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  String filter = "Semua";

  List<String> jenisList = [
    "Semua",
    "Sparepart",
    "Hewan",
    "Makanan",
    "Pakaian",
  ];

  @override
  Widget build(BuildContext context) {
    // 🔍 FILTER DATA
    List filtered = widget.dataResi.where((e) {
      if (filter == "Semua") return true;
      return e['jenis'] == filter;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("List Bookingan"), centerTitle: true),

      body: Column(
        children: [
          // 🔽 DROPDOWN FILTER
          Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
              initialValue: filter,
              decoration: InputDecoration(
                labelText: "Filter Jenis Barang",
                border: OutlineInputBorder(),
              ),
              items: jenisList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  filter = val!;
                });
              },
            ),
          ),

          // 📦 LIST DATA
          Expanded(
            child: filtered.isEmpty
                ? Center(child: Text("Belum ada data"))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      var d = filtered[i];

                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),

                          // 🔥 BARCODE
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 90,
                                height: 40,
                                child: BarcodeWidget(
                                  barcode: Barcode.code128(),
                                  data: d['resi'].toString(),
                                  drawText: false,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                d['resi'].toString(),
                                style: TextStyle(fontSize: 9),
                              ),
                            ],
                          ),

                          // 📄 DATA
                          title: Text(
                            "Kota: ${d['kota']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jenis: ${d['jenis']}"),
                              Text("Pcs: ${d['pcs']} | Kg: ${d['kg']}"),
                              Text(
                                "Status: ${getStatus(d['status'])}",
                                style: TextStyle(
                                  color: getColor(d['status']),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // 🔥 BUTTON TRACKING
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text("Track"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TrackingPage(data: d),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // 🔥 STATUS TEXT
  String getStatus(int status) {
    List s = ["Diproses", "Dikirim", "Perjalanan", "Sampai"];
    return s[status];
  }

  // 🔥 WARNA STATUS
  Color getColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
