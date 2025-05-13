import 'package:flutter/material.dart';

class CalculateView extends StatelessWidget {
  final String type;

  const CalculateView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (type) {
      case 'project':
        content = _ProjectCalculation();
        break;
      case 'tonaya':
        content = _TonayaCalculation();
        break;
      case 'other':
        content = _OtherCalculation();
        break;
      default:
        content = Center(child: Text("نوع غير معروف"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("حساب الأجرة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}
class _ProjectCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("حساب أجرة مشروع"),
        // اضف الحقول هنا مثل عدد الركاب – الأجرة لكل راكب
      ],
    );
  }
}

class _TonayaCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("حساب أجرة توناية"),
        // اضف الحقول هنا
      ],
    );
  }
}

class _OtherCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("حساب أجرة أخرى"),
        // اضف الحقول هنا
      ],
    );
  }
}
