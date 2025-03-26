import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch_listen_read/provider.dart';

class TestWidget extends ConsumerStatefulWidget {
  const TestWidget({super.key});

  @override
  ConsumerState<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends ConsumerState<TestWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(counter3NotifierProvider.notifier).increment();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
