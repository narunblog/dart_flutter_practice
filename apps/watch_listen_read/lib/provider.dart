import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class Counter1Notifier extends _$Counter1Notifier {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
}

@riverpod
class Counter2Notifier extends _$Counter2Notifier {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
}

/// keepAliveの挙動確認用
@Riverpod(keepAlive: true)
class Counter3Notifier extends _$Counter3Notifier {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}
