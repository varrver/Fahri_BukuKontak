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
  });
}