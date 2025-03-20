import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectElevatedButtonRule extends DartLintRule {
  const AvoidDirectElevatedButtonRule() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_elevated_button',
    problemMessage:
        'Flutter準規のElevatedButtonウィジェットを呼び出さず、コンポーネント化されたElevatedButtonウィジェットを使用してください',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // ファイルのパスを取得
    // [ pages ]をパスに含むファイルのみを対象にする
    final path = resolver.source.uri;
    if (!path.toString().contains('pages')) return;

    context.registry.addInstanceCreationExpression((node) {
      // インスタンスの型名を取得
      final createdType = node.constructorName.type.type;

      // インスタンスの型がElevatedButtonと一致する場合はエラーを出す
      if (createdType != null && createdType.toString() == 'ElevatedButton') {
        reporter.atNode(node, _code);
      }
    });
  }
}
