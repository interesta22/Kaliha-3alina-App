import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/models/route_model.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/presentation/widgets/result_card.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/controller/how_to_go_controller.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/presentation/widgets/modern_dropdown.dart';
// how_to_go_view.dart

class HowToGoView extends StatefulWidget {
  const HowToGoView({super.key});

  @override
  State<HowToGoView> createState() => _HowToGoViewState();
}

class _HowToGoViewState extends State<HowToGoView> {
  final controller = HowToGoController();
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    controller.init(context, setState);
  }

  void _handleSearch() {
    controller.search();
    setState(() {
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: AppColors.primary,
        title: Text('إزاي أروح؟ 🚍 ', style: AppTextStyles.font20BlackBold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            modernDropdown(
              'المحافظة',
              controller.selectedGovernorate,
              controller.governorates,
              controller.onGovernorateChanged,
            ),
            verticaalSpacing(15),
            modernDropdown(
              'من',
              controller.from,
              controller.locations,
              controller.onFromChanged,
            ),
            verticaalSpacing(15),
            modernDropdown(
              'إلى',
              controller.to,
              controller.locations,
              controller.onToChanged,
            ),
            verticaalSpacing(30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleSearch,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'اعرف الطريق',
                      style: AppTextStyles.font17WhiteMedium.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                horizentalSpacing(10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    fixedSize: const Size(55, 55),
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: AppColors.primary,
                    size: 30,
                  ),
                  onPressed: () {
                    controller.reset();
                    setState(() {
                      showResult = false;
                    });
                  },
                ),
              ],
            ),
            verticaalSpacing(30),
            if (showResult) ...[
              if (controller.result != null &&
                  controller.result is RouteModel &&
                  controller.result!.isNotEmpty)
                resultCard(controller.result!)
              else if (controller.result != null &&
                  controller.result is List<RouteModel> &&
                  (controller.result as List<RouteModel>).isNotEmpty)
                multiStepResultCard(controller.result as List<RouteModel>)
              else if (controller.from != null && controller.to != null)
                failureResultCard(controller.from!, controller.to!),
            ],
          ],
        ),
      ),
    );
  }
}
