import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectAppBarRule extends DartLintRule {
  const AvoidDirectAppBarRule() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_app_bar',
    problemMessage:
        'Flutter準規のAppBarウィジェットを呼び出さず、コンポーネント化されたAppBarウィジェットを使用してください',
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

      // インスタンスの型がAppBarと一致する場合はエラーを出す
      if (createdType != null && createdType.toString() == 'AppBar') {
        reporter.atNode(node, _code);
      }
    });
  }
}
