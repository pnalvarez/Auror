import 'package:auror_design_system/molecules/badges/badge.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/cards/recall_card.dart';
import 'package:auror_design_system/molecules/chips/status_chip.dart';
import 'package:auror_design_system/molecules/inputfields/input_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  path: '[Design System]/[Molecules]/DsBadge',
  name: 'Interactive',
  type: DsBadge,
)
Widget dsBadgeInteractive(BuildContext context) {
  return const Center(
    child: DsBadge(label: 'Premium', leadingIcon: Icons.workspace_premium),
  );
}

@widgetbook.UseCase(
  path: '[Design System]/[Molecules]/StatusChip',
  name: 'Interactive',
  type: StatusChip,
)
Widget statusChipInteractive(BuildContext context) {
  return const Center(
    child: StatusChip(label: 'Em progresso', state: StatusChipState.primary),
  );
}

@widgetbook.UseCase(
  path: '[Design System]/[Molecules]/SecondaryButton',
  name: 'Interactive',
  type: SecondaryButton,
)
Widget secondaryButtonInteractive(BuildContext context) {
  return Center(
    child: SecondaryButton(label: 'Secundário', action: () {}),
  );
}

@widgetbook.UseCase(
  path: '[Design System]/[Molecules]/RecallCard',
  name: 'Interactive',
  type: RecallCard,
)
Widget recallCardInteractive(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: RecallCard(
      topic: 'Recordação',
      title: 'Qual é a segunda lei de Newton?',
      description: 'Escolha a fórmula correta.',
      expectedAnswer: 'F = m · a',
    ),
  );
}

@widgetbook.UseCase(
  path: '[Design System]/[Molecules]/PrimaryButton',
  name: 'Interactive',
  type: PrimaryButton,
)
Widget primaryButtonInteractive(BuildContext context) {
  return Center(
    child: PrimaryButton(label: 'Primário', action: () {}),
  );
}

@widgetbook.UseCase(
  path: '[Design System]/[Molecules]/InputField',
  name: 'Interactive',
  type: InputField,
)
Widget inputFieldInteractive(BuildContext context) {
  return const _InputFieldDemo();
}

class _InputFieldDemo extends StatefulWidget {
  const _InputFieldDemo();

  @override
  State<_InputFieldDemo> createState() => _InputFieldDemoState();
}

class _InputFieldDemoState extends State<_InputFieldDemo> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InputField(
        label: 'Campo',
        controller: _controller,
        placeholder: 'Digite algo',
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}
