import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  void launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {
        'label': 'واتساب',
        'icon': Icons.phone,
        'url': 'https://wa.me/201278576046',
        'colors': [Colors.green.shade700, Colors.greenAccent],
      },
      {
        'label': 'فيسبوك',
        'icon': Icons.facebook,
        'url': 'https://www.facebook.com/share/19G2mUWTzN/',
        'colors': [Colors.blue.shade700, Colors.lightBlueAccent],
      },
      {
        'label': 'لينكد إن',
        'icon': Icons.camera_alt,
        'url':
            'https://www.linkedin.com/in/ahmedabdulaziz10?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
        'colors': [Colors.pink.shade400, Colors.orangeAccent],
      },
      {
        'label': 'جيت هاب',
        'icon': Icons.send,
        'url': 'https://github.com/interesta22',
        'colors': [Colors.blue.shade400, Colors.blue.shade100],
      },
      {
        'label': 'جيميل',
        'icon': Icons.email,
        'url': 'mailto:dd0231571@gmail.com',
        'colors': [Colors.deepOrange, Colors.orangeAccent],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: AppColors.background,
        title: Text('تواصل معنا', style: AppTextStyles.font20BlackBold),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          padding: const EdgeInsets.all(16),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return Material(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: () => launch(contact['url'] as String),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff2DAA9E), Color(0xff66D2CE)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 20.w,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 90.w,
                        height: 60.h,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          contact['icon'] as IconData,
                          size: 48.w,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Text(
                          contact['label'] as String,
                          style: AppTextStyles.font17BlackMedium.copyWith(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
