import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/inputfields/input_field.dart';
import 'package:flutter/material.dart';

/// Showcases [InputField] states: default, value, error, disabled, prefix/suffix.
class InputFieldDemo extends StatefulWidget {
  const InputFieldDemo({super.key});

  @override
  State<InputFieldDemo> createState() => _InputFieldDemoState();
}

class _InputFieldDemoState extends State<InputFieldDemo> {
  late final TextEditingController _emptyController;
  late final TextEditingController _filledController;
  late final TextEditingController _errorController;
  late final TextEditingController _prefixController;
  late final TextEditingController _disabledController;
  late final TextEditingController _noLabelController;
  late final TextEditingController _infoLabelController;
  bool _showError = true;

  @override
  void initState() {
    super.initState();
    _emptyController = TextEditingController();
    _filledController = TextEditingController(text: 'Sample value');
    _errorController = TextEditingController(text: 'invalid@');
    _prefixController = TextEditingController(text: '42');
    _disabledController = TextEditingController(text: 'Cannot edit');
    _noLabelController = TextEditingController();
    _infoLabelController = TextEditingController();
  }

  @override
  void dispose() {
    _emptyController.dispose();
    _filledController.dispose();
    _errorController.dispose();
    _prefixController.dispose();
    _disabledController.dispose();
    _noLabelController.dispose();
    _infoLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Outlined fields with label, optional label info control, focus, error, and disabled states.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Default (empty)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        InputField(
          label: 'Email',
          controller: _emptyController,
          placeholder: 'you@example.com',
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('With value', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        InputField(
          label: 'Display name',
          controller: _filledController,
          placeholder: 'Name',
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Error', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        InputField(
          label: 'Email',
          controller: _errorController,
          placeholder: 'you@example.com',
          errorMessage: _showError ? 'Enter a valid email address.' : null,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacings.m),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => setState(() => _showError = !_showError),
            child: Text(_showError ? 'Clear error' : 'Show error'),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Disabled', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        InputField(
          label: 'Read-only field',
          controller: _disabledController,
          isEnabled: false,
          onChanged: (_) {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Prefix & suffix', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        InputField(
          label: 'Weight',
          controller: _prefixController,
          placeholder: '0',
          prefixText: '\$ ',
          suffixText: ' kg',
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Label with info', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        InputField(
          label: 'API key',
          controller: _infoLabelController,
          placeholder: 'sk-…',
          infoIcon: true,
          onInfoTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Info action (e.g. open docs).')),
            );
          },
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('No label', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        InputField(
          label: '',
          controller: _noLabelController,
          placeholder: 'Placeholder only',
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }
}
