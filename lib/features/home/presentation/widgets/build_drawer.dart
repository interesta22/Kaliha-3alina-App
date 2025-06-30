import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:khaliha_3alina/features/home/presentation/views/about_view.dart';
import 'package:khaliha_3alina/features/home/presentation/views/contact_us_view.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/views/trips_view.dart';

Widget buildDrawerContent(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF49BEB6),
    body: Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF49BEB6)),
            child: Center(
              child: Image.asset('lib/core/assets/images/Frame 35.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.trip_origin_outlined, color: Colors.white),
            title: Text(
              'رحلاتي السابقة',
              style: AppTextStyles.font17BlackMedium.copyWith(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripsView()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.white),
            title: Text(
              'عن التطبيق',
              style: AppTextStyles.font17BlackMedium.copyWith(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutView()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.contact_mail, color: Colors.white),
            title: Text(
              'تواصل معنا',
              style: AppTextStyles.font17BlackMedium.copyWith(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsView()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: Colors.white),
            title: Text(
              'مشاركة التطبيق',
              style: AppTextStyles.font17BlackMedium.copyWith(
                color: Colors.white,
              ),
            ),
            onTap: () {
              // هنا ممكن تضيف كود لمشاركة التطبيق
            },
          ),
        ],
      ),
    ),
  );
}
