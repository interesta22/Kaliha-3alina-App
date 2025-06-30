import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/core/constants/contacts.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/contact_item.dart';

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
            return ContactItem(contact: contact);
          },
        ),
      ),
    );
  }
}
