import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/repo/how_to_go_controller.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/custom_button.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/presentation/widgets/modern_dropdown.dart';

class HowToGoForm extends StatelessWidget {
  final HowToGoRepository controller;
  final VoidCallback onSearchPressed;
  final VoidCallback onResetPressed;

  const HowToGoForm({
    super.key,
    required this.controller,
    required this.onSearchPressed,
    required this.onResetPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: CustomButton(
                buttonText: 'اعرف الطريق',
                onPressed: onSearchPressed,
              ),
            ),
            horizentalSpacing(10),
            IconButton(
              icon: const Icon(Icons.refresh_rounded,
                  color: AppColors.primary, size: 30),
              onPressed: onResetPressed,
            ),
          ],
        ),
      ],
    );
  }
}
