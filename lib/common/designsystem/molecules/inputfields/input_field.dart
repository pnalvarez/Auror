import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Outlined text field with label, matching mibook [InputField] behavior:
/// label, placeholder, prefix/suffix, error helper, enabled/disabled, focus ring.
class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.isEnabled = true,
    this.placeholder = '',
    this.suffixText,
    this.prefixText,
    this.errorMessage,
    this.keyboardType,
    required this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final bool isEnabled;
  final String placeholder;
  final String? suffixText;
  final String? prefixText;
  final String? errorMessage;
  final TextInputType? keyboardType;
  final ValueChanged<String> onChanged;

  bool get _hasError =>
      errorMessage != null && errorMessage!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final labelStyle = body4Light.copyWith(
      color: _hasError
          ? AppColors.Error.error
          : AppColors.Text.Body.primary,
    );

    final borderRadius = BorderRadius.circular(AppRadius.m);

    OutlineInputBorder border(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    final hintColor = AppColors.Surface.onSurfaceVariant;
    final inputColor =
        isEnabled ? AppColors.Text.Body.primary : AppColors.Text.Body.disabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label, style: body4Light),
          const SizedBox(height: AppSpacings.xs2),
        ],
        TextField(
          controller: controller,
          enabled: isEnabled,
          keyboardType: keyboardType,
          style: body4Light.copyWith(color: inputColor),
          cursorColor: AppColors.Primary.primary,
          decoration: InputDecoration(
            isDense: false,
            filled: true,
            fillColor: isEnabled
                ? AppColors.Surface.surfaceContainerLowest
                : AppColors.Surface.surfaceContainerLow,
            hintText: placeholder.isEmpty ? null : placeholder,
            hintStyle: body4Light.copyWith(color: hintColor),
            suffixText: suffixText,
            prefixText: prefixText,
            suffixStyle: body4Light.copyWith(color: hintColor),
            prefixStyle: body4Light.copyWith(color: hintColor),
            errorText: _hasError ? errorMessage : null,
            errorStyle: body3Medium.copyWith(color: AppColors.Error.error),
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSpacings.l,
              horizontal: AppSpacings.l,
            ),
            border: border(AppColors.Outline.outline),
            enabledBorder: border(AppColors.Outline.outline),
            focusedBorder: border(AppColors.Primary.primary, width: 2),
            disabledBorder: border(AppColors.Outline.outlineVariant),
            errorBorder: border(AppColors.Error.error),
            focusedErrorBorder: border(AppColors.Error.error, width: 2),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
