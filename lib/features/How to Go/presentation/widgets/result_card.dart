import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/data/models/route_model.dart';

Widget resultCard(RouteModel route) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.directions_bus,
                color: AppColors.primary,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "${route.from} → ${route.to}",
                  style: AppTextStyles.font17BlackMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (route.notes != null && route.notes!.isNotEmpty)
            Text(
              "ملاحظات: ${route.notes!}",
              style: AppTextStyles.font17BlackRegular.copyWith(
                color: Colors.grey[800],
                fontSize: 15,
              ),
            ),
          const SizedBox(height: 8),
          Text(
            "طريقة المواصلات: ${route.method}",
            style: AppTextStyles.font17BlackRegular.copyWith(
              color: Colors.grey[800],
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "السعر: ${route.price} جنيه",
            style: AppTextStyles.font17BlackRegular.copyWith(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  Widget failureResultCard(String from, String to) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.redAccent,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "مفيش طريق مباشر",
                  style: AppTextStyles.font17BlackMedium.copyWith(
                    color: Colors.redAccent,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "من $from إلى $to، حاول تغير نقطة الانطلاق أو الوجهة.",
                  style: AppTextStyles.font17BlackRegular.copyWith(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget multiStepResultCard(List<RouteModel> path) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.route, color: AppColors.primary, size: 28),
            const SizedBox(width: 10),
            Text("الطريق المقترح", style: AppTextStyles.font17BlackMedium),
          ],
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < path.length; i++) ...[
          Text(
            "المرحلة ${i + 1}: من ${path[i].from} إلى ${path[i].to}",
            style: AppTextStyles.font17BlackMedium,
          ),
          const SizedBox(height: 4),
          if (path[i].notes != null && path[i].notes!.isNotEmpty)
            Text(
              "ملاحظات: ${path[i].notes!}",
              style: AppTextStyles.font17BlackRegular.copyWith(fontSize: 14),
            ),
          Text(
            "طريقة المواصلات: ${path[i].method}",
            style: AppTextStyles.font17BlackRegular.copyWith(fontSize: 14),
          ),
          Text(
            "السعر: ${path[i].price} جنيه",
            style: AppTextStyles.font17BlackRegular.copyWith(
              color: AppColors.primary,
              fontSize: 15,
            ),
          ),
          if (i != path.length - 1) const Divider(height: 20),
        ],
        const SizedBox(height: 10),
        Text(
          "إجمالي السعر: ${path.fold<double>(0, (sum, r) => sum + (double.tryParse(r.price) ?? 0.0))} جنيه",

          style: AppTextStyles.font17BlackMedium.copyWith(
            color: AppColors.primary,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
