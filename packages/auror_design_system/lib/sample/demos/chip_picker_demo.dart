import 'package:auror_design_system/molecules/chips/chip_picker.dart';
import 'package:flutter/material.dart';

/// [ChipPicker] with sample categories; tap to change selection.
class ChipPickerDemo extends StatefulWidget {
  const ChipPickerDemo({super.key});

  @override
  State<ChipPickerDemo> createState() => _ChipPickerDemoState();
}

class _ChipPickerDemoState extends State<ChipPickerDemo> {
  static const _items = [
    'All',
    'Personal development',
    'General',
    'Productivity',
  ];

  var _selected = 1;

  @override
  Widget build(BuildContext context) {
    return ChipPicker(
      items: _items,
      selectedIndex: _selected,
      onSelected: (i) => setState(() => _selected = i),
    );
  }
}
