import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Buku Kontak', home: KontakPage());
  }
}

// Model data untuk kontak
class Kontak {
  final String nama;
  final String email;
  final String noHp;

  Kontak({required this.nama, required this.email, required this.noHp});
}

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  // List untuk menampung data kontak
  final List<Kontak> _listKontak = [];

  // Controller untuk masing-masing field input
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();

  // Fungsi untuk menyimpan data
  void _simpanKontak() {
    if (_namaController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _noHpController.text.isNotEmpty) {
      setState(() {
        _listKontak.add(
          Kontak(
            nama: _namaController.text,
            email: _emailController.text,
            noHp: _noHpController.text,
          ),
        );

        // Mengosongkan form setelah simpan
        _namaController.clear();
        _emailController.clear();
        _noHpController.clear();
      });
    }
  }

  @override
  void dispose() {
    // Membersihkan controller dari memori
    _namaController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Kontak', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Bagian Form Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _noHpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'No Handphone'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _simpanKontak,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),

          // Bagian Daftar Kontak (ListView)
          Expanded(
            child: ListView.builder(
              itemCount: _listKontak.length,
              itemBuilder: (context, index) {
                final kontak = _listKontak[index];
                return ListTile(
                  leading: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.black, size: 24),
                    ],
                  ),
                  title: Text(
                    kontak.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${kontak.email}\n${kontak.noHp}'),
                  isThreeLine: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
