import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/repo/how_to_go_controller.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/presentation/widgets/how_to_go_form.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/presentation/widgets/how_to_go_result_section.dart';


// how_to_go_view.dart
class HowToGoView extends StatefulWidget {
  const HowToGoView({super.key});

  @override
  State<HowToGoView> createState() => _HowToGoViewState();
}

class _HowToGoViewState extends State<HowToGoView> {
  final controller = HowToGoRepository();
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    controller.init(context, setState);
  }

  void _handleSearch() {
    controller.search();
    setState(() => showResult = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
        ),
        backgroundColor: AppColors.background,
        title: Text('إزاي أروح؟ 🚍 ', style: AppTextStyles.font20BlackBold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            HowToGoForm(
              controller: controller,
              onSearchPressed: _handleSearch,
              onResetPressed: () {
                controller.reset();
                setState(() => showResult = false);
              },
            ),
            verticaalSpacing(30),
            if (showResult)
              HowToGoResultSection(
                controller: controller,
              ),
          ],
        ),
      ),
    );
  }
}



