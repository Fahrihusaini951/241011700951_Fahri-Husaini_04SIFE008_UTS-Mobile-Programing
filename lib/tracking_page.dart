import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  final Map data;

  TrackingPage({super.key, required this.data});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final List statusList = ["Diproses", "Dikirim", "Dalam Perjalanan", "Sampai"];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  IconData getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.settings;
      case 1:
        return Icons.local_shipping;
      case 2:
        return Icons.route;
      case 3:
        return Icons.check_circle;
      default:
        return Icons.circle;
    }
  }

  Color getColor(int index) {
    switch (index) {
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

  @override
  Widget build(BuildContext context) {
    int current = widget.data['status'] ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text("Tracking Paket")),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 NO RESI
            Text(
              "No Resi: ${widget.data['resi']}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 15),

            // 🔥 CARD DETAIL CUSTOMER
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Pengiriman",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    Divider(),

                    buildRow(
                      Icons.person,
                      "Pengirim",
                      widget.data['nama_pengirim'],
                    ),
                    buildRow(
                      Icons.person_outline,
                      "Penerima",
                      widget.data['nama_penerima'],
                    ),
                    buildRow(Icons.category, "Jenis", widget.data['jenis']),
                    buildRow(
                      Icons.straighten,
                      "Dimensi",
                      widget.data['dimensi'],
                    ),
                    buildRow(Icons.inventory, "Pcs", widget.data['pcs']),
                    buildRow(Icons.scale, "Berat", "${widget.data['kg']} Kg"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Status Pengiriman",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // 🔥 STATUS LIST
            Expanded(
              child: ListView.builder(
                itemCount: statusList.length,
                itemBuilder: (context, i) {
                  bool aktif = i <= current;

                  return ListTile(
                    leading: aktif
                        ? RotationTransition(
                            turns: controller,
                            child: Icon(
                              getIcon(i),
                              color: getColor(i),
                              size: 28,
                            ),
                          )
                        : Icon(Icons.radio_button_unchecked),

                    title: Text(
                      statusList[i],
                      style: TextStyle(
                        color: aktif ? getColor(i) : Colors.grey,
                        fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔥 BUTTON UPDATE STATUS
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (current < 3) {
                    setState(() {
                      widget.data['status']++;
                    });
                  }
                },
                child: Text("Update Status"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 WIDGET UNTUK RAPIIKAN DATA
  Widget buildRow(IconData icon, String title, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 16),
          SizedBox(width: 6),
          Text("$title : "),
          Expanded(
            child: Text(
              value != null ? value.toString() : "-",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
