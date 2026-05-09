import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final resi = TextEditingController();
  final kota = TextEditingController();
  final pcs = TextEditingController();
  final kg = TextEditingController();

  void simpan() {
    if (resi.text.isEmpty ||
        kota.text.isEmpty ||
        pcs.text.isEmpty ||
        kg.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Isi semua data")));
      return;
    }

    Navigator.pop(context, {
      "resi": resi.text,
      "kota": kota.text,
      "pcs": pcs.text,
      "kg": kg.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Resi")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: resi,
              decoration: InputDecoration(labelText: "No Resi"),
            ),
            TextField(
              controller: kota,
              decoration: InputDecoration(labelText: "Kota Tujuan"),
            ),
            TextField(
              controller: pcs,
              decoration: InputDecoration(labelText: "Pcs"),
            ),
            TextField(
              controller: kg,
              decoration: InputDecoration(labelText: "Kilogram"),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: simpan, child: Text("Simpan")),
          ],
        ),
      ),
    );
  }
}
