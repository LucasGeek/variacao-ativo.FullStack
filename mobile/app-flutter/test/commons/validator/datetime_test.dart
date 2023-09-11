import 'package:variacao_ativo/commons/commons.dart';
import 'package:test/test.dart';

void main() {
  group('ValidDateTimeNull extension', () {
    test('isNotNull should return true if DateTime is not null', () {
      final dateTime = DateTime.now();
      expect(dateTime.isNotNull(), isTrue);
    });

    test('isNotNull should return false if DateTime is null', () {
      DateTime? dateTime;
      expect(dateTime.isNotNull(), isFalse);
    });

    test('isValid should return true for a valid DateTime', () {
      final dateTime = DateTime(2022, 1, 1); // Valid date
      expect(dateTime.isValid(), isTrue);
    });
  });

  group('ValidDateTime extension', () {
    test('toDDMMYYYY should return formatted date for a valid DateTime', () {
      final dateTime = DateTime(2022, 1, 1); // Valid date
      expect(dateTime.toDDMMYYYY(), equals('01/01/2022'));
    });

    test('isValid should return true for a valid DateTime', () {
      final dateTime = DateTime(2022, 1, 1); // Valid date
      expect(dateTime.isValid(), isTrue);
    });
  });
}
