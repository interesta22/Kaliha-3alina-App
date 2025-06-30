import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({super.key, required this.contact});
  final Map<String, dynamic> contact;

  @override
  Widget build(BuildContext context) {
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
  }
}
