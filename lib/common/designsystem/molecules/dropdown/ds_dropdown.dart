import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Expandable row: [label], chevron (right collapsed / down expanded), and [child] when open.
class DsDropdown extends StatefulWidget {
  const DsDropdown({
    super.key,
    required this.label,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  });

  final String label;
  final Widget child;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<DsDropdown> createState() => _DsDropdownState();
}

class _DsDropdownState extends State<DsDropdown> {
  late bool _expanded = widget.initiallyExpanded;

  void _toggle() {
    setState(() => _expanded = !_expanded);
    widget.onExpansionChanged?.call(_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final labelStyle = body2Medium.copyWith(color: scheme.onSurface);
    const iconSize = 24.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacings.s),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.label,
                      style: labelStyle,
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_more : Icons.chevron_right,
                    size: iconSize,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: _expanded
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacings.s,
                    bottom: AppSpacings.xs,
                  ),
                  child: widget.child,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
