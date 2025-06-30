import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/about_content.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 25.w, left: 17.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'lib/core/assets/images/Frame 35.png', // غير المسار حسب اللوجو بتاعك
                  height: 100,
                ),
              ),
              verticaalSpacing(20),
              AboutTitle(),
              verticaalSpacing(15),
              AboutContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutTitle extends StatelessWidget {
  const AboutTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'تطبيق خليها علينا',
      style: AppTextStyles.font20BlackBold.copyWith(
        fontSize: 24,
        color: Color(0xff2DAA9E),
      ),
    );
  }
}

