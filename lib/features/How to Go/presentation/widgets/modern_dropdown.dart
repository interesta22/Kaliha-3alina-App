import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';

Widget modernDropdown(
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          floatingLabelStyle: AppTextStyles.font17BlackRegular.copyWith(
            color: Colors.grey[800],
            fontSize: 16,
          ),
          hintStyle: AppTextStyles.font17BlackRegular.copyWith(
            color: Colors.grey[800],
            fontSize: 16,
          ),
          labelText: label,
          border: InputBorder.none,
          labelStyle: AppTextStyles.font17BlackRegular.copyWith(
            color: Colors.grey[800],
            fontSize: 16,
          ),
        ),
        value: value,
        isExpanded: true,
        items:
            items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
