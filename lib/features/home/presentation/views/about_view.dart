import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: AppColors.background,
        title: Text('عن التطبيق', style: AppTextStyles.font20BlackBold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'lib/core/assets/images/Frame 35.png', // غير المسار حسب اللوجو بتاعك
                  height: 100,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'تطبيق خليها علينا',
                style: AppTextStyles.font20BlackBold.copyWith(
                  fontSize: 24,
                  color: Color(0xff2DAA9E),
                ),
              ),
              verticaalSpacing(15),
              Text(
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
          
"خليها علينا" بيخلي الحسابات أوضح وأبسط، ويريّحك من الجدال!
          ''',
                style: AppTextStyles.font17BlackMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
