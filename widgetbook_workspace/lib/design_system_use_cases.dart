import 'package:auror_design_system/molecules/badges/badge.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/cards/recall_card.dart';
import 'package:auror_design_system/molecules/chips/status_chip.dart';
import 'package:auror_design_system/molecules/inputfields/input_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Interactive',
  type: DsBadge,
  path: '[Design System]/[Molecules]/DsBadge',
)
Widget dsBadgeInteractive(BuildContext context) {
  final variant = context.knobs.object.dropdown<BadgeVariant>(
    label: 'Variant',
    options: BadgeVariant.values,
    labelBuilder: (v) => v.name,
  );
  final showIcon = context.knobs.boolean(
    label: 'Leading icon',
    initialValue: false,
  );
  return Center(
    child: DsBadge(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'Desenvolvimento Pessoal',
      ),
      variant: variant,
      leadingIcon: showIcon ? Icons.workspace_premium_outlined : null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: StatusChip,
  path: '[Design System]/[Molecules]/StatusChip',
)
Widget statusChipInteractive(BuildContext context) {
  return Center(
    child: StatusChip(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'Active',
      ),
      state: context.knobs.object.dropdown<StatusChipState>(
        label: 'State',
        options: StatusChipState.values,
        labelBuilder: (s) => s.name,
      ),
      hasDot: context.knobs.boolean(
        label: 'Show dot',
        initialValue: true,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: SecondaryButton,
  path: '[Design System]/[Molecules]/SecondaryButton',
)
Widget secondaryButtonInteractive(BuildContext context) {
  return Center(
    child: SecondaryButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'Cancel',
      ),
      action: () {},
      brand: context.knobs.object.dropdown<ButtonBrand>(
        label: 'Brand',
        options: ButtonBrand.values,
        labelBuilder: (b) => b.name,
      ),
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      loading: context.knobs.boolean(
        label: 'Loading',
        initialValue: false,
      ),
      isExpanded: context.knobs.boolean(
        label: 'Expanded',
        initialValue: false,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: RecallCard,
  path: '[Design System]/[Molecules]/RecallCard',
)
Widget recallCardInteractive(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: RecallCard(
        topic: context.knobs.string(label: 'Topic', initialValue: 'Biology'),
        title: context.knobs.string(
          label: 'Title',
          initialValue: 'What is the powerhouse of the cell?',
        ),
        description: context.knobs.string(
          label: 'Description',
          initialValue: 'Recall the term from your last session.',
        ),
        expectedAnswer: context.knobs.string(
          label: 'Expected answer',
          initialValue: 'Mitochondria',
        ),
        initialRevealed: context.knobs.boolean(
          label: 'Initially revealed',
          initialValue: false,
        ),
        topicChipState: context.knobs.object.dropdown<StatusChipState>(
          label: 'Topic chip',
          options: StatusChipState.values,
          labelBuilder: (s) => s.name,
        ),
        onFeedback: (_) {},
        onReveal: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: PrimaryButton,
  path: '[Design System]/[Molecules]/PrimaryButton',
)
Widget primaryButtonInteractive(BuildContext context) {
  final leading = context.knobs.object.dropdown<_LeadingIconOption>(
    label: 'Leading icon',
    options: _LeadingIconOption.values,
    labelBuilder: (o) => o.label,
  );

  return Center(
    child: PrimaryButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'Continue',
      ),
      action: () {},
      brand: context.knobs.object.dropdown<ButtonBrand>(
        label: 'Brand',
        options: ButtonBrand.values,
        labelBuilder: (b) => b.name,
      ),
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      loading: context.knobs.boolean(
        label: 'Loading',
        initialValue: false,
      ),
      isExpanded: context.knobs.boolean(
        label: 'Expanded',
        initialValue: false,
      ),
      leadingIcon: leading.icon,
    ),
  );
}

enum _LeadingIconOption {
  none('None', null),
  arrowBack('Arrow back', Icons.arrow_back),
  check('Check', Icons.check);

  const _LeadingIconOption(this.label, this.icon);

  final String label;
  final IconData? icon;
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: InputField,
  path: '[Design System]/[Molecules]/InputField',
)
Widget inputFieldInteractive(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Email',
  );
  final placeholder = context.knobs.string(
    label: 'Placeholder',
    initialValue: 'you@example.com',
  );
  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );
  final errorKnob = context.knobs.string(
    label: 'Error message (empty = none)',
    initialValue: '',
  );
  final appearance = context.knobs.object.dropdown<InputFieldAppearance>(
    label: 'Appearance',
    options: InputFieldAppearance.values,
    labelBuilder: (a) => a.name,
  );

  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: _InputFieldKnobs(
        label: label,
        placeholder: placeholder,
        enabled: enabled,
        errorMessage: errorKnob.trim().isEmpty ? null : errorKnob.trim(),
        appearance: appearance,
      ),
    ),
  );
}

class _InputFieldKnobs extends StatefulWidget {
  const _InputFieldKnobs({
    required this.label,
    required this.placeholder,
    required this.enabled,
    required this.errorMessage,
    required this.appearance,
  });

  final String label;
  final String placeholder;
  final bool enabled;
  final String? errorMessage;
  final InputFieldAppearance appearance;

  @override
  State<_InputFieldKnobs> createState() => _InputFieldKnobsState();
}

class _InputFieldKnobsState extends State<_InputFieldKnobs> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'sample@example.com');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: widget.label,
      controller: _controller,
      isEnabled: widget.enabled,
      placeholder: widget.placeholder,
      errorMessage: widget.errorMessage,
      appearance: widget.appearance,
      onChanged: (_) => setState(() {}),
    );
  }
}
