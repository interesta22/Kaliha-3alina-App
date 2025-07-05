import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/read_cubit.dart';
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
              child: Image.asset('lib/core/assets/images/Frame 5.png'),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.taxi, color: Colors.white),
            title: Text(
              'رحلاتي السابقة',
              style: AppTextStyles.font17BlackMedium.copyWith(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create: (_) => ReadCubit()..getRides(),
                        child: TripsView(),
                      ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.circleInfo, color: Colors.white),
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
            leading: Icon(FontAwesomeIcons.message, color: Colors.white),
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
            leading: Icon(FontAwesomeIcons.share, color: Colors.white),
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
