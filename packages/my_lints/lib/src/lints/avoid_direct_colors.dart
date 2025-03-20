import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectColorsRule extends DartLintRule {
  const AvoidDirectColorsRule() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_colors',
    problemMessage: 'Flutter準規のColorsを呼び出さず、AppColorを設定して使用してください',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // ファイルのパスを取得
    // [ app_color.dart ]以外のファイルを対象にする
    final path = resolver.source.uri;
    if (path.toString().contains('app_color')) return;

    // 引数を取得して、Flutter準規の[ Colors ]を使用している箇所があればエラーを出す
    context.registry.addArgumentList((node) {
      // プロパティを取得する
      for (final argument in node.arguments) {
        // プロパティに対してColorを指定するようになっているものを特定する
        if (argument.staticType.toString() == 'Color') {
          // プロパティ値の中に[Colors.]が使われていればエラーとする
          for (final value in argument.childEntities) {
            if (value.toString().contains('Colors.')) {
              reporter.atNode(argument, _code);
            }
          }
        }
      }
    });
  }
}
