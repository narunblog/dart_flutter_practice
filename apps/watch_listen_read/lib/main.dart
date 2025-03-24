import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: const MainApp())));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter1Notifier = ref.watch(counter1NotifierProvider.notifier);
    final counter2Notifier = ref.watch(counter2NotifierProvider.notifier);
    final counter1 = ref.watch(counter1NotifierProvider);
    final counter2 = ref.read(counter2NotifierProvider);
    print('初回ビルドとcounter1が変わるたびに呼ばれる');

    ref.listen(counter2NotifierProvider, (prev, next) {
      if (next == 1) {
        // ダイアログ表示
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: Text('Counter2が1になりました'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('counter1=$counter1, counter2=$counter2'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    counter1Notifier.increment();
                  },
                  child: Text('Increment Counter1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    counter1Notifier.decrement();
                  },
                  child: Text('Decrement Counter1'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    counter2Notifier.increment();
                  },
                  child: Text('Increment Counter2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    counter2Notifier.decrement();
                  },
                  child: Text('Decrement Counter2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
