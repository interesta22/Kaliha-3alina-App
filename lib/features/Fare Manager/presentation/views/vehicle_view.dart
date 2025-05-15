import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/views/other_view.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/views/suzuki_view.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/views/microbus_view.dart';

class VehicleView extends StatelessWidget {
  final String type;

  const VehicleView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (type) {
      case 'project':
        content = MicrobusView();
        break;
      case 'tonaya':
        content = SuzukiView();
        break;
      case 'other':
        content = OtherView();
        break;
      default:
        content = Center(child: Text("نوع غير معروف"));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(16.0.w), child: content),
      ),
    );
  }
}


