import 'package:flutter/material.dart';
import 'booking_list_page.dart';

class ProfilePage extends StatefulWidget {
  final String nama;
  final String posisi;
  final String nim;
  final String kelas;
  final List<Map<String, dynamic>> dataResi;

  const ProfilePage({
    super.key,
    required this.nama,
    required this.posisi,
    required this.nim,
    required this.kelas,
    required this.dataResi,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String about;
  String skill = "Analisa, Motivasi Diri, Kreativitas, Kerjasama";
  String interest = "Logistik, Teknologi, Automotif, Musik";

  String alamat = "Jl. Kihajar Dewantoro, Kota Tangerang";
  String email = "Fahrihusaini@gmail.com";
  String telepon = "0857-4683-7964";
  String website = "www.fahriblogspot.com";

  List<Map<String, String>> pendidikan = [
    {
      "tahun": "2024 - Sekarang",
      "institusi": "Universitas Pamulang",
      "deskripsi":
          "Mahasiswa Sistem Informasi, sedang menempuh semester aktif dengan fokus pada pengembangan aplikasi mobile menggunakan Flutter.",
    },
    {
      "tahun": "2014 - 2017",
      "institusi": "SMk Bangun Nusantara Tangerang",
      "deskripsi":
          "Jurusan TKR, aktif dalam ekstrakulikuler Otomotif, Dan Juga Osis.",
    },
    {
      "tahun": "2011 - 2014",
      "institusi": "MTS Negri 8 Jakarta",
      "deskripsi":
          "aktif dalam ekstrakulikuler Pramuka,Paskibra, Futsal, Dan Juga Osis.",
    },
  ];

  List<Map<String, String>> pengalamanKerja = [
    {
      "tahun": "2023 - Sekarang",
      "perusahaan": "Lion Express",
      "deskripsi":
          "Bertugas sebagai staff input data dan tracking paket pengiriman logistik.",
    },
    {
      "tahun": "2022 - 2023",
      "perusahaan": "Freelance Developer",
      "deskripsi":
          "Mengerjakan proyek aplikasi mobile berbasis Flutter untuk beberapa klien UMKM.",
    },
  ];

  List<Map<String, dynamic>> bahasa = [
    {"nama": "Indonesia", "level": 1.0},
    {"nama": "Inggris", "level": 0.7},
    {"nama": "Mandarin", "level": 0.3},
  ];

  List<String> software = ["Flutter", "Dart", "Android Studio", "Figma", "Git"];

  String filterBarang = "Semua";
  List<String> listBarang = [
    "Semua",
    "Sparepart",
    "Hewan",
    "Makanan",
    "Pakaian",
  ];

  @override
  void initState() {
    super.initState();
    about =
        'Dengan mempelajari Flutter, saya bisa mengembangkan skill di bidang coding. '
        'Ini merupakan Tugas UTS yang saya buat dengan semangat yang kuat untuk berkuliah '
        'dan mengerjakan tugas di sela-sela kesibukan kerja saya.';
  }

  void editData() {
    TextEditingController aboutC = TextEditingController(text: about);
    TextEditingController skillC = TextEditingController(text: skill);
    TextEditingController interestC = TextEditingController(text: interest);
    TextEditingController alamatC = TextEditingController(text: alamat);
    TextEditingController emailC = TextEditingController(text: email);
    TextEditingController teleponC = TextEditingController(text: telepon);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Profile"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: aboutC,
                maxLines: 4,
                decoration: InputDecoration(labelText: "About / Profil"),
              ),
              SizedBox(height: 8),
              TextField(
                controller: skillC,
                decoration: InputDecoration(
                  labelText: "Kemampuan (pisah koma)",
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: interestC,
                decoration: InputDecoration(
                  labelText: "Hobi & Minat (pisah koma)",
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: alamatC,
                decoration: InputDecoration(labelText: "Alamat"),
              ),
              SizedBox(height: 8),
              TextField(
                controller: emailC,
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 8),
              TextField(
                controller: teleponC,
                decoration: InputDecoration(labelText: "Telepon"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                about = aboutC.text;
                skill = skillC.text;
                interest = interestC.text;
                alamat = alamatC.text;
                email = emailC.text;
                telepon = teleponC.text;
              });
              Navigator.pop(context);
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void hapusData() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Konfirmasi Hapus"),
        content: Text("Yakin ingin menghapus semua data profil?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                about = "";
                skill = "";
                interest = "";
              });
              Navigator.pop(context);
            },
            child: Text("Hapus"),
          ),
        ],
      ),
    );
  }

  static const Color teal = Color(0xFF009688);
  static const Color darkTeal = Color(0xFF00695C);
  static const Color bgGrey = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    List filtered = widget.dataResi.where((e) {
      if (filterBarang == "Semua") return true;
      return e['jenis'] == filterBarang;
    }).toList();

    return Scaffold(
      backgroundColor: bgGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== HEADER (Cover + Avatar + Nama) =====
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Cover
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Husain.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        foregroundDecoration: BoxDecoration(
                          color: teal.withValues(alpha: 0.3),
                        ),
                      ),
                      // Avatar
                      Positioned(
                        bottom: -50,
                        left: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 6),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/merapi.jpeg'),
                          ),
                        ),
                      ),
                      // Edit icon
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: editData,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.edit, size: 16, color: teal),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 58),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nama,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          widget.posisi,
                          style: TextStyle(
                            fontSize: 14,
                            color: teal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.school, size: 14, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              "${widget.kelas}  •  NIM: ${widget.nim}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Tombol Aksi
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _actionButton(
                                "List Bookingan",
                                Icons.list_alt,
                                teal,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BookingListPage(
                                        dataResi: widget.dataResi,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 8),
                              _outlineButton(
                                "Edit Profile",
                                Icons.edit,
                                teal,
                                editData,
                              ),
                              SizedBox(width: 8),
                              _outlineButton(
                                "Hapus",
                                Icons.delete,
                                Colors.red,
                                hapusData,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // ===== LAYOUT 2 KOLOM (kiri: kontak, bahasa, kemampuan, software, hobi | kanan: profil, pendidikan, pengalaman) =====
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== KOLOM KIRI =====
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        // KONTAK
                        _cvCard(
                          title: "KONTAK",
                          icon: Icons.contact_phone,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _contactItem(Icons.location_on, alamat),
                              _contactItem(Icons.email, email),
                              _contactItem(Icons.phone, telepon),
                              _contactItem(Icons.language, website),
                            ],
                          ),
                        ),

                        SizedBox(height: 8),

                        // BAHASA
                        _cvCard(
                          title: "BAHASA",
                          icon: Icons.language,
                          child: Column(
                            children: bahasa.map((b) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      b['nama'] as String,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: (b['level'] as num).toDouble(),
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(teal),
                                        minHeight: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 8),

                        // KEMAMPUAN
                        _cvCard(
                          title: "KEMAMPUAN",
                          icon: Icons.star,
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: skill.isEmpty
                                ? [Text("-", style: TextStyle(fontSize: 12))]
                                : skill.split(',').map((s) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: teal.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: teal.withValues(alpha: 0.4),
                                        ),
                                      ),
                                      child: Text(
                                        s.trim(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: darkTeal,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                          ),
                        ),

                        SizedBox(height: 8),

                        // SOFTWARE
                        _cvCard(
                          title: "SOFTWARE",
                          icon: Icons.computer,
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: software.map((s) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.blueGrey.shade200,
                                  ),
                                ),
                                child: Text(
                                  s,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blueGrey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 8),

                        // MINAT & HOBI
                        _cvCard(
                          title: "MINAT & HOBI",
                          icon: Icons.favorite,
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: interest.isEmpty
                                ? [Text("-", style: TextStyle(fontSize: 12))]
                                : interest.split(',').map((s) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          _hobiIcon(s.trim()),
                                          color: teal,
                                          size: 22,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          s.trim(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
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

                  SizedBox(width: 8),

                  // ===== KOLOM KANAN =====
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        // PROFIL / ABOUT
                        _cvCard(
                          title: "PROFIL",
                          icon: Icons.person,
                          child: Text(
                            about.isEmpty ? "-" : about,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),

                        // PENDIDIKAN
                        _cvCard(
                          title: "PENDIDIKAN",
                          icon: Icons.school,
                          child: Column(
                            children: pendidikan.map((p) {
                              return _timelineItem(
                                tahun: p['tahun']!,
                                judul: p['institusi']!,
                                deskripsi: p['deskripsi']!,
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 8),

                        // PENGALAMAN KERJA
                        _cvCard(
                          title: "PENGALAMAN KERJA",
                          icon: Icons.work,
                          child: Column(
                            children: pengalamanKerja.map((p) {
                              return _timelineItem(
                                tahun: p['tahun']!,
                                judul: p['perusahaan']!,
                                deskripsi: p['deskripsi']!,
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 8),

                        // RIWAYAT BOOKING
                        _cvCard(
                          title: "RIWAYAT KIRIMAN",
                          icon: Icons.local_shipping,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                initialValue: filterBarang,
                                decoration: InputDecoration(
                                  labelText: "Filter Jenis",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  isDense: true,
                                ),
                                items: listBarang
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => filterBarang = val!),
                              ),
                              SizedBox(height: 10),
                              filtered.isEmpty
                                  ? Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.inbox,
                                              color: Colors.grey,
                                              size: 32,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "Belum ada data",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: filtered.length,
                                      itemBuilder: (context, index) {
                                        final resi = filtered[index];
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 6),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: teal.withValues(alpha: 0.05),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: teal.withValues(
                                                alpha: 0.2,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.local_shipping,
                                                color: teal,
                                                size: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      resi['resi'] ?? '-',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${resi['jenis'] ?? '-'} • ${resi['kota'] ?? '-'}",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===== HELPER WIDGETS =====

  Widget _cvCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: teal, size: 16),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: darkTeal,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          Divider(color: teal.withValues(alpha: 0.3), height: 12),
          child,
        ],
      ),
    );
  }

  Widget _contactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 13, color: teal),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineItem({
    required String tahun,
    required String judul,
    required String deskripsi,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: teal, shape: BoxShape.circle),
              ),
              Container(
                width: 2,
                height: 50,
                color: teal.withValues(alpha: 0.3),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tahun,
                  style: TextStyle(
                    fontSize: 10,
                    color: teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  judul,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 14, color: Colors.white),
      label: Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _outlineButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 14, color: color),
      label: Text(label, style: TextStyle(fontSize: 12, color: color)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  IconData _hobiIcon(String hobi) {
    switch (hobi.toLowerCase()) {
      case 'gaming':
        return Icons.games;
      case 'musik':
        return Icons.music_note;
      case 'logistik':
        return Icons.local_shipping;
      case 'teknologi':
        return Icons.computer;
      case 'foto':
        return Icons.camera_alt;
      case 'olahraga':
        return Icons.sports_soccer;
      default:
        return Icons.star;
    }
  }
}
