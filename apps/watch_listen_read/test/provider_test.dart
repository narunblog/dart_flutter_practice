import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watch_listen_read/provider.dart';
import 'package:watch_listen_read/test_widget.dart';

void main() {
  testWidgets(
    'keepAliveがtrueの場合、initStateやuseEffectでref.readで呼ばれた後も破棄されるまでは同じオブジェクトが使われることの確認',
    (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(child: TestWidget()));

      final element = widgetTester.element(find.byType(TestWidget));
      final container = ProviderScope.containerOf(element);
      // 前提：プロバイダーのkeepAliveはtrueとする。適当なウィジェットのinitStateでref.readで呼び出した値を変更し、その値が保持されていることを確認する
      // 期待値：Counter3Notifierのstateが1になっていること
      final counter = container.read(counter3NotifierProvider);
      expect(counter, 1);
      // 前提：命令的に破棄する
      // 期待値：Counter3Notifierのstateが0になっていること
      container.invalidate(counter3NotifierProvider);
      expect(container.read(counter3NotifierProvider), 0);
    },
  );
}
