import 'package:flutter/material.dart';
import 'dart:math';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // CONTROLLER
  final pengirim = TextEditingController();
  final penerima = TextEditingController();
  final alamat = TextEditingController();
  final pcs = TextEditingController();
  final kg = TextEditingController();
  final p = TextEditingController();
  final l = TextEditingController();
  final t = TextEditingController();

  // DATA
  List<String> jenisBarang = [];
  String service = "Onepack";
  bool asuransi = false;

  double totalHarga = 0;

  List<String> listBarang = [
    "Sparepart",
    "Makanan",
    "Pakaian",
    "Pecah Belah",
    "Hewan",
    "Tumbuhan",
    "Ikan",
    "Cairan",
    "DG",
  ];

  // HITUNG HARGA
  void hitungHarga() {
    double berat = double.tryParse(kg.text) ?? 0;
    int jumlah = int.tryParse(pcs.text) ?? 0;

    double dimensi =
        (double.tryParse(p.text) ?? 0) *
        (double.tryParse(l.text) ?? 0) *
        (double.tryParse(t.text) ?? 0) /
        6000;

    setState(() {
      totalHarga = (berat + dimensi) * 5000 + (jumlah * 2000);
      if (asuransi) totalHarga += 10000;
    });
  }

  // GENERATE RESI
  String generateResi() {
    Random r = Random();
    return "RESI${r.nextInt(999999)}";
  }

  // SIMPAN DATA
  void simpan() {
    if (pengirim.text.isEmpty || penerima.text.isEmpty || alamat.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data belum lengkap!")));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Anda yakin untuk booking?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Tidak"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.pop(context, {
                "resi": generateResi(),
                "nama_pengirim": pengirim.text,
                "nama_penerima": penerima.text,
                "kota": alamat.text,
                "pcs": pcs.text,
                "kg": kg.text,
                "jenis": jenisBarang.isNotEmpty ? jenisBarang.first : "Lainnya",
                "dimensi": "${p.text} x ${l.text} x ${t.text}",
                "service": service,
                "asuransi": asuransi,
                "harga": totalHarga,
                "status": 0,
              });
            },
            child: Text("Ya"),
          ),
        ],
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Barang")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PENGIRIM
            TextField(
              controller: pengirim,
              decoration: InputDecoration(labelText: "Nama Pengirim"),
            ),

            TextField(
              controller: penerima,
              decoration: InputDecoration(labelText: "Nama Penerima"),
            ),

            TextField(
              controller: alamat,
              decoration: InputDecoration(labelText: "Alamat Penerima"),
            ),

            SizedBox(height: 10),

            // JENIS BARANG
            Text("Jenis Barang", style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              children: listBarang.map((e) {
                return CheckboxListTile(
                  title: Text(e),
                  value: jenisBarang.contains(e),
                  onChanged: (val) {
                    setState(() {
                      if (val!) {
                        jenisBarang.add(e);
                      } else {
                        jenisBarang.remove(e);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            // PCS & KG
            TextField(
              controller: pcs,
              decoration: InputDecoration(labelText: "Jumlah PCS"),
              keyboardType: TextInputType.number,
              onChanged: (_) => hitungHarga(),
            ),

            TextField(
              controller: kg,
              decoration: InputDecoration(labelText: "Berat (Kg)"),
              keyboardType: TextInputType.number,
              onChanged: (_) => hitungHarga(),
            ),

            SizedBox(height: 10),

            Text(
              "Jenis Service",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioGroup<String>(
              groupValue: service,
              onChanged: (val) {
                setState(() {
                  service = val.toString();
                });
              },
              child: Column(
                children: ["Onepack", "Regpack", "Bosspack"].map((e) {
                  return RadioListTile<String>(title: Text(e), value: e);
                }).toList(),
              ),
            ),

            // DIMENSI
            Text(
              "Dimensi (P x L x T)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: p,
                    decoration: InputDecoration(labelText: "Panjang"),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => hitungHarga(),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: l,
                    decoration: InputDecoration(labelText: "Lebar"),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => hitungHarga(),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: t,
                    decoration: InputDecoration(labelText: "Tinggi"),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => hitungHarga(),
                  ),
                ),
              ],
            ),

            // ASURANSI
            CheckboxListTile(
              title: Text("Asuransi (+10.000)"),
              value: asuransi,
              onChanged: (val) {
                setState(() {
                  asuransi = val!;
                  hitungHarga();
                });
              },
            ),

            SizedBox(height: 10),

            // TOTAL
            Text(
              "Total Harga: Rp ${totalHarga.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: simpan,
                child: Text("Simpan Booking"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
