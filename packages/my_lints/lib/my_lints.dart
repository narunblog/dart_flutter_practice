import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/lints/avoid_direct_app_bar.dart';
import 'src/lints/avoid_direct_colors.dart';
import 'src/lints/avoid_direct_elevated_button.dart';
import 'src/lints/avoid_direct_text.dart';
import 'src/lints/avoid_direct_text_form_field.dart';

PluginBase createPlugin() => _Linter();

// Lint Ruleを登録するためのクラス
// PluginBaseクラスのメソッドをオーバーライドしてルールを登録していく
class _Linter extends PluginBase {
  // このメソッドでルールを登録
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      const AvoidDirectTextRule(),
      const AvoidDirectElevatedButtonRule(),
      const AvoidDirectAppBarRule(),
      const AvoidDirectTextFormFieldRule(),
      const AvoidDirectColorsRule(),
    ];
  }

  // Assist（入力補助）を行いたいときはこっちに登録
  @override
  List<Assist> getAssists() => [];
}
