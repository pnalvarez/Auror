import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Whether to use fixed design-system tokens or the ambient [ThemeData.colorScheme].
///
/// [InputFieldAppearance.light] keeps catalog / light surfaces. [InputFieldAppearance.theme]
/// maps fills and outlines to [ColorScheme] so fields sit correctly on dark surfaces
/// while keeping the same primary accent axis as the ambient theme.
enum InputFieldAppearance { light, theme }

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.label = '',
    required this.controller,
    this.isEnabled = true,
    this.placeholder = '',
    this.suffixText,
    this.prefixText,
    this.errorMessage,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.appearance = InputFieldAppearance.light,
    this.focusNode,
    this.infoIcon = false,
    this.onInfoTap,
    this.minLines,
    this.maxLines,
    required this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isEnabled;
  final String placeholder;
  final String? suffixText;
  final String? prefixText;
  final String? errorMessage;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final InputFieldAppearance appearance;
  final bool infoIcon;
  final VoidCallback? onInfoTap;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<String> onChanged;

  bool get _hasError => errorMessage != null && errorMessage!.trim().isNotEmpty;

  static OutlineInputBorder _outline(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.m),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final useTheme = appearance == InputFieldAppearance.theme;

    final Color labelColor;
    if (_hasError) {
      labelColor = useTheme ? scheme.error : AppColors.Error.error;
    } else {
      labelColor = useTheme
          ? scheme.onSurfaceVariant
          : AppColors.Text.Body.primary;
    }

    final Color hintColor = useTheme
        ? scheme.onSurfaceVariant
        : AppColors.Surface.onSurfaceVariant;

    final Color inputColor = useTheme
        ? (isEnabled
              ? scheme.onSurface
              : scheme.onSurface.withValues(alpha: 0.38))
        : (isEnabled
              ? AppColors.Text.Body.primary
              : AppColors.Text.Body.disabled);

    final Color fillColor;
    if (useTheme) {
      fillColor = isEnabled
          ? scheme.surfaceContainerLow
          : scheme.surfaceContainerLow.withValues(alpha: 0.72);
    } else {
      fillColor = isEnabled
          ? AppColors.Surface.surfaceContainerLowest
          : AppColors.Surface.surfaceContainerLow;
    }

    final Color cursorColor = useTheme
        ? scheme.primary
        : AppColors.Primary.primary;

    final Color outlineNormal;
    final Color outlineFocused;
    final Color outlineError;
    if (useTheme) {
      outlineNormal = scheme.outline.withValues(alpha: 0.45);
      outlineFocused = scheme.primary;
      outlineError = scheme.error;
    } else {
      outlineNormal = AppColors.Outline.outline;
      outlineFocused = AppColors.Primary.primary;
      outlineError = AppColors.Error.error;
    }

    final Color disabledOutline = useTheme
        ? scheme.outline.withValues(alpha: 0.28)
        : AppColors.Outline.outlineVariant;

    final errorStyle = body4Light.copyWith(
      color: useTheme ? scheme.error : AppColors.Error.error,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(label, style: body4Light.copyWith(color: labelColor)),
              if (infoIcon)
                Transform.translate(
                  offset: const Offset(-AppSpacings.s, 0),
                  child: IconButton(
                    onPressed: onInfoTap,
                    tooltip: 'More info',
                    style: IconButton.styleFrom(
                      foregroundColor: labelColor,
                      minimumSize: const Size(16, 16),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: const Icon(Icons.info_outline, size: 16),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacings.xs2),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: isEnabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: body4Light.copyWith(color: inputColor),
          cursorColor: cursorColor,
          decoration: InputDecoration(
            isDense: false,
            filled: true,
            fillColor: fillColor,
            hintText: placeholder.isEmpty ? null : placeholder,
            hintStyle: body4Light.copyWith(color: hintColor),
            suffixText: suffixText,
            prefixText: prefixText,
            suffixStyle: body4Light.copyWith(color: hintColor),
            prefixStyle: body4Light.copyWith(color: hintColor),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSpacings.l,
              horizontal: AppSpacings.l,
            ),
            border: _outline(_hasError ? outlineError : outlineNormal),
            enabledBorder: _outline(_hasError ? outlineError : outlineNormal),
            focusedBorder: _outline(
              _hasError ? outlineError : outlineFocused,
              width: 2,
            ),
            disabledBorder: _outline(disabledOutline),
          ),
          minLines: obscureText ? 1 : minLines,
          maxLines: obscureText ? 1 : maxLines,
          onChanged: onChanged,
        ),
        if (_hasError) ...[
          const SizedBox(height: AppSpacings.xs2),
          Text(errorMessage!.trim(), style: errorStyle),
        ],
      ],
    );
  }
}
