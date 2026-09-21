import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kontak_form/main.dart';

void main() {
  group('Contact model', () {
    test('toMap menghasilkan semua field', () {
      final contact = Contact(
        name: 'Budi',
        email: 'budi@mail.com',
        phone: '081234567890',
        category: 'Teman',
      );
      expect(contact.toMap(), {
        'name': 'Budi',
        'email': 'budi@mail.com',
        'phone': '081234567890',
        'category': 'Teman',
      });
    });

    test('fromMap mengembalikan Contact ber-id plus nilai null-safe', () {
      final contact = Contact.fromMap('doc123', {
        'name': 'Ani',
        'email': 'ani@mail.com',
        'phone': '0812',
        'category': null,
      });
      expect(contact.id, 'doc123');
      expect(contact.name, 'Ani');
      expect(contact.email, 'ani@mail.com');
      expect(contact.phone, '0812');
      expect(contact.category, isNull);
    });

    test('fromMap aman untuk dokumen dengan field kosong', () {
      final contact = Contact.fromMap('doc2', {});
      expect(contact.name, '');
      expect(contact.email, '');
      expect(contact.phone, '');
      expect(contact.category, isNull);
    });

    test('fromMap aman untuk field bertipe salah (mis. angka)', () {
      final contact = Contact.fromMap('doc3', {
        'name': 123,
        'email': 'a@b.c',
        'phone': '0812',
        'category': 99,
      });
      expect(contact.name, '');
      expect(contact.email, 'a@b.c');
      expect(contact.phone, '0812');
      expect(contact.category, isNull);
    });
  });

  group('EditContactPage', () {
    testWidgets('simpan gagal (id kosong) tidak menutup halaman dan menampilkan SnackBar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditContactPage(
                        contact: Contact(
                          name: 'Budi',
                          email: 'budi@mail.com',
                          phone: '081234567890',
                          category: 'Teman',
                        ),
                      ),
                    ),
                  ),
                  child: const Text('buka'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('buka'));
      await tester.pumpAndSettle();

      // Isi form dengan data valid agar validasi lolos.
      await tester.enterText(find.byType(TextFormField).at(0), 'Budi');
      await tester.enterText(find.byType(TextFormField).at(1), 'budi@mail.com');
      await tester.enterText(find.byType(TextFormField).at(2), '081234567890');

      await tester.tap(find.text('Simpan Perubahan'));
      await tester.pumpAndSettle();

      // Halaman edit tetap terbuka dan SnackBar guard id kosong tampil.
      expect(find.byType(EditContactPage), findsOneWidget);
      expect(find.text('Kontak belum memiliki ID, tidak dapat disimpan'), findsOneWidget);
    });
  });
}