import 'package:flutter/material.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/models/route_model.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/repo/how_to_go_controller.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/presentation/widgets/result_card.dart';

class HowToGoResultSection extends StatelessWidget {
  final HowToGoRepository controller;

  const HowToGoResultSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final result = controller.result;
    if (result != null && result is RouteModel && result.isNotEmpty) {
      return resultCard(result);
    } else if (result != null &&
        result is List<RouteModel> &&
        result.isNotEmpty) {
      return multiStepResultCard(result);
    } else if (controller.from != null && controller.to != null) {
      return failureResultCard(controller.from!, controller.to!);
    } else {
      return const SizedBox.shrink();
    }
  }
}
