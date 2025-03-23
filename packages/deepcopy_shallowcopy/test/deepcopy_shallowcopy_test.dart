import 'package:flutter_test/flutter_test.dart';

import 'package:deepcopy_shallowcopy/models.dart';

void main() {
  group('ディープコピーとシャローコピーのテスト', () {
    test('リストのシャローコピーとディープコピーの違い', () {
      // オリジナルリスト
      final original = [
        {'name': 'Alice', 'age': 25},
        {'name': 'Bob', 'age': 30},
      ];

      // シャローコピー（List.from()は新しいリストを作るが、中の要素は同じ参照）
      final shallowCopy = original;

      // ディープコピー（各要素も新しくコピー）
      final deepCopy =
          original.map((item) => Map<String, dynamic>.from(item)).toList();

      // シャローコピーのテスト
      expect(identical(original, shallowCopy), isTrue);
      expect(identical(original[0], shallowCopy[0]), isTrue); // 要素は同じ参照

      // 元のリストの要素を変更するとシャローコピーも影響を受ける
      original[0]['age'] = 26;
      expect(shallowCopy[0]['age'], 26);

      // ディープコピーのテスト
      expect(identical(original, deepCopy), isFalse); // リスト自体は別オブジェクト
      expect(identical(original[0], deepCopy[0]), isFalse); // 要素も別オブジェクト

      // 元のリストの要素を変更してもディープコピーは影響を受けない
      original[1]['age'] = 31;
      expect(deepCopy[1]['age'], 30);
    });

    test('ネストされたリストのシャローコピーとディープコピー', () {
      // ネストされたリスト
      final original = [
        [1, 2, 3],
        [4, 5, 6],
      ];

      // シャローコピー
      final shallowCopy = original;

      // ディープコピー
      final deepCopy =
          original.map((innerList) => List<int>.from(innerList)).toList();

      // 内部リストを変更
      original[0][0] = 99;

      // シャローコピーは影響を受ける
      expect(shallowCopy[0][0], 99);

      // ディープコピーは影響を受けない
      expect(deepCopy[0][0], 1);
    });

    test('カスタムクラスのシャローコピーとディープコピー', () {
      // テスト用のクラスはlib/models.dartに移動しました

      final original = Container([Item(1), Item(2), Item(3)]);
      final shallowCopy = original.shallowCopy();
      final deepCopy = original.deepCopy();

      // シャローコピーはリストも要素も同じオブジェクト
      expect(identical(original.items, shallowCopy.items), isTrue);
      expect(identical(original.items[0], shallowCopy.items[0]), isTrue);

      // ディープコピーはリストも要素も別オブジェクト
      expect(identical(original.items, deepCopy.items), isFalse);
      expect(identical(original.items[0], deepCopy.items[0]), isFalse);

      // 元のオブジェクトの要素を変更
      original.items[0].value = 99;

      // シャローコピーは影響を受ける
      expect(shallowCopy.items[0].value, 99);

      // ディープコピーは影響を受けない
      expect(deepCopy.items[0].value, 1);
    });

    test('Map型のシャローコピーとディープコピー', () {
      // オリジナルのMap
      final original = {
        'name': 'Alice',
        'details': {'age': 25, 'city': 'Wonderland'},
      };

      // シャローコピー
      final shallowCopy = original;

      // ディープコピー
      final deepCopy = {
        'name': original['name'],
        'details': Map<String, dynamic>.from(
          original['details'] as Map<String, dynamic>,
        ),
      };

      // シャローコピーのテスト
      expect(identical(original, shallowCopy), isTrue);
      expect(identical(original['details'], shallowCopy['details']), isTrue);

      // 元のMapの内部Mapを変更するとシャローコピーも影響を受ける
      (original['details'] as Map<String, dynamic>)['age'] = 26;
      expect((shallowCopy['details'] as Map<String, dynamic>)['age'], 26);

      // ディープコピーのテスト
      expect(identical(original, deepCopy), isFalse); // Map自体は別オブジェクト
      expect(
        identical(original['details'], deepCopy['details']),
        isFalse,
      ); // 内部のMapも別オブジェクト

      // 元のMapの内部Mapを変更してもディープコピーは影響を受けない
      (original['details'] as Map<String, dynamic>)['city'] = 'New Wonderland';
      expect(
        (deepCopy['details'] as Map<String, dynamic>)['city'],
        'Wonderland',
      );
    });

    test('Set型のシャローコピーとディープコピー', () {
      // オリジナルのSet
      final original = {
        {'name': 'Alice', 'age': 25},
        {'name': 'Bob', 'age': 30},
      };

      // シャローコピー
      final shallowCopy = original;

      // ディープコピー
      // 各要素のMapを新しいMapとしてコピーする
      final deepCopy =
          original
              .map(
                (item) =>
                    Map<String, dynamic>.from(item as Map<String, dynamic>),
              )
              .toSet();

      // シャローコピーのテスト
      expect(identical(original, shallowCopy), isTrue);
      expect(identical(original.first, shallowCopy.first), isTrue);

      // 元のSetの要素を変更するとシャローコピーも影響を受ける
      (original.first as Map<String, dynamic>)['age'] = 26;
      expect(shallowCopy.first['age'], 26);

      // ディープコピーのテスト
      expect(identical(original, deepCopy), isFalse); // Set自体は別オブジェクト
      expect(identical(original.first, deepCopy.first), isFalse); // 要素も別オブジェクト

      // 元のSetの要素を変更してもディープコピーは影響を受けない
      (original.last as Map<String, dynamic>)['age'] = 31;
      expect(deepCopy.last['age'], 30); // この検証に失敗する可能性があります（Setの順序保証がないため）
    });

    test('int型のシャローコピーとディープコピー', () {
      var originalInt = 42;

      // シャローコピー（プリミティブ型は値そのものがコピーされる）
      final shallowCopyInt = originalInt;

      // シャローコピーのテスト（値が同じなのでtrueとなる）
      expect(identical(originalInt, shallowCopyInt), isTrue);

      // プリミティブ型は値そのものがコピーされるため、変更しても影響を受けない
      originalInt = 43;
      expect(shallowCopyInt, 42);
    });

    test('String型のシャローコピーとディープコピー', () {
      var originalString = 'Hello';

      // シャローコピー（プリミティブ型は値そのものがコピーされる）
      final shallowCopyString = originalString;

      // シャローコピーのテスト
      expect(identical(originalString, shallowCopyString), isTrue);

      // プリミティブ型は値そのものがコピーされるため、変更しても影響を受けない
      originalString = 'World';
      expect(shallowCopyString, 'Hello');
    });

    test('double型のシャローコピーとディープコピー', () {
      var originalDouble = 3.14;

      // シャローコピー（プリミティブ型は値そのものがコピーされる）
      final shallowCopyDouble = originalDouble;

      // シャローコピーのテスト
      expect(identical(originalDouble, shallowCopyDouble), isTrue);

      // プリミティブ型は値そのものがコピーされるため、変更しても影響を受けない
      originalDouble = 4.14;
      expect(shallowCopyDouble, 3.14);
    });

    test('bool型のシャローコピーとディープコピー', () {
      var originalBool = true;

      // シャローコピー（プリミティブ型は値そのものがコピーされる）
      final shallowCopyBool = originalBool;

      // シャローコピーのテスト
      expect(identical(originalBool, shallowCopyBool), isTrue);

      // プリミティブ型は値そのものがコピーされるため、変更しても影響を受けない
      originalBool = false;
      expect(shallowCopyBool, true);
    });
  });
}
