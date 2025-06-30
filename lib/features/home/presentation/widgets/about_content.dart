import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '''تطبيق "خليها علينا" هو أداة ذكية تساعدك في حساب وتوزيع أجرة المواصلات بطريقة سهلة وسريعة، سواء كنت راكب أو سواق.
          
          مناسب لجميع وسائل النقل الجماعي زي:
          • الميكروباص  
          • التوناية  
          • أو أي وسيلة مواصلات تانية
          
          مميزات التطبيق:
          • تحدد الأجرة الفردية  
          • تضيف عدد الركاب  
          • تسجّل المدفوع من كل راكب  
          • التطبيق يحسبلك تلقائيًا مين دفع كام  
          
"خليها علينا" بيخلي الحسابات أوضح وأبسط، ويريّحك من الجدال!''',
      style: AppTextStyles.font17BlackMedium,
    );
  }
}
