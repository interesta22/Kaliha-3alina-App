import 'package:flutter/services.dart';


class DecimalTextInputFormatter extends TextInputFormatter {
  final int maxDigitsBeforeDecimal;
  final int maxDigitsAfterDecimal;

  DecimalTextInputFormatter({
    required this.maxDigitsBeforeDecimal,
    required this.maxDigitsAfterDecimal,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text == "") return newValue;

    final parts = text.split('.');

    // جزء الأرقام قبل العلامة
    final beforeDecimal = parts[0];
    if (beforeDecimal.length > maxDigitsBeforeDecimal) {
      return oldValue;
    }

    // جزء الأرقام بعد العلامة
    if (parts.length > 1) {
      final afterDecimal = parts[1];
      if (afterDecimal.length > maxDigitsAfterDecimal) {
        return oldValue;
      }
    }

    return newValue;
  }
}
