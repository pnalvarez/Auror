import 'package:auror/common/designsystem/sample/demos/circular_loader_demo.dart';
import 'package:auror/common/designsystem/sample/demos/ds_action_buttons_demo.dart';
import 'package:auror/common/designsystem/sample/demos/input_field_demo.dart';
import 'package:flutter/material.dart';

/// Registry for design-system demo screens: maps a [demoId] to a title and
/// the [Widget] that lists component states.
@immutable
class DsDemoEntry {
  const DsDemoEntry({required this.title, required this.demo});

  final String title;
  final Widget demo;
}

abstract final class DsDemoCatalog {
  static DsDemoEntry? lookup(String demoId) {
    return switch (demoId) {
      'action_buttons' => const DsDemoEntry(
          title: 'Action buttons',
          demo: ActionButtonsDemo(),
        ),
      'circular_loader' => const DsDemoEntry(
          title: 'Circular loader',
          demo: CircularLoaderDemo(),
        ),
      'input_field' => const DsDemoEntry(
          title: 'Input field',
          demo: InputFieldDemo(),
        ),
      _ => null,
    };
  }
}
