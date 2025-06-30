import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/custom_tap_to_expand.dart';

class UsageTipsSection extends StatelessWidget {
  const UsageTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomTapToExpand(
          title: 'طريقة استخدام التطبيق',
          content: '- أول حاجة، هتدخل أجرة الفرد...'
              '\n\n- بعدين تبدأ تضيف كل راكب وتقول هو دفع كام.',
        ),
        SizedBox(height: 16),
        CustomTapToExpand(
          title: 'تشوف مثال ؟',
          content: 'محمد دفع عن 3 أفراد ودفع 20 جنيه...'
              '\n\nالتطبيق هيحسبلك هو عليه فلوس ولا ليه باقي.',
        ),
      ],
    );
  }
}