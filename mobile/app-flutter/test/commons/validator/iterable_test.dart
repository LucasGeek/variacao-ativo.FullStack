import 'package:variacao_ativo/commons/commons.dart';
import 'package:test/test.dart';

void main() {
  group('ExtendedIterable', () {
    test('mapIndexed should return a new iterable with transformed values', () {
      final iterable = [1, 2, 3, 4, 5];
      final mappedIterable = iterable.mapIndexed((value, index) => value * index);

      expect(mappedIterable.toList(), [0, 2, 6, 12, 20]);
    });

    test('mapIndexed should pass the correct index to the transform function', () {
      final iterable = ['a', 'b', 'c', 'd'];
      final mappedIterable = iterable.mapIndexed((value, index) => '$value$index');

      expect(mappedIterable.toList(), ['a0', 'b1', 'c2', 'd3']);
    });

    test('mapIndexed should return an empty iterable for an empty source iterable', () {
      final emptyIterable = <int>[];
      final mappedIterable = emptyIterable.mapIndexed((value, index) => value * index);

      expect(mappedIterable.isEmpty, true);
    });
  });
}
