import 'package:flutter/material.dart';

class TripFilterChips extends StatefulWidget {
  final Function(String) onFilterSelected;

  const TripFilterChips({super.key, required this.onFilterSelected});

  @override
  State<TripFilterChips> createState() => _TripFilterChipsState();
}

class _TripFilterChipsState extends State<TripFilterChips> {
  final List<String> filters = ['الكل', 'مشروع', 'توناية', 'أخرى'];
  String selected = 'الكل';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children:
          filters.map((filter) {
            final bool isSelected = selected == filter;
            return ChoiceChip(
              showCheckmark: false,
              label: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xff2DAA9E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selected = filter;
                });
                widget.onFilterSelected(filter);
              },
              backgroundColor: Colors.white,
              selectedColor: const Color(0xff2DAA9E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Color(0xff2DAA9E)),
              ),
            );
          }).toList(),
    );
  }
}
