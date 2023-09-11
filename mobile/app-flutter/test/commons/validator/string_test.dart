import 'package:variacao_ativo/commons/commons.dart';
import 'package:test/test.dart';

void main() {
  group('ValidString', () {
    test('isNotNullOrEmpty should return true for a non-null and non-empty string', () {
      const nonEmptyString = 'Hello';
      final result = nonEmptyString.isNotNullOrEmpty();

      expect(result, true);
    });

    test('isNotNullOrEmpty should return false for a null string', () {
      String? nullString;
      final result = nullString.isNotNullOrEmpty();

      expect(result, false);
    });

    test('isNotNullOrEmpty should return false for an empty string', () {
      const emptyString = '';
      final result = emptyString.isNotNullOrEmpty();

      expect(result, false);
    });

    test('isNotNullOrEmpty should return false for a string with only whitespace characters', () {
      const whitespaceString = '    ';
      final result = whitespaceString.isNotNullOrEmpty();

      expect(result, false);
    });
  });
}
