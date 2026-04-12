import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

const double _kChipPickerMinHeight = 24;

/// Row + horizontal scroll height; bounds the viewport so pills stay short in
/// loose parents (e.g. [Stack]).
const double _kChipPickerBarHeight = 32;

/// Horizontal row of single-select pill chips in a horizontal scroll view.
/// Selected uses [ColorScheme.primary], unselected [ColorScheme.secondary].
class ChipPicker extends StatelessWidget {
  const ChipPicker({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> items;

  /// Index into [items]. Ignored when [items] is empty.
  final int selectedIndex;

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    assert(
      selectedIndex >= 0 && selectedIndex < items.length,
      'selectedIndex must be within items',
    );

    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: _kChipPickerBarHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacings.s),
              _ChipPickerPill(
                label: items[i],
                selected: i == selectedIndex,
                scheme: scheme,
                onTap: () => onSelected(i),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChipPickerPill extends StatelessWidget {
  const _ChipPickerPill({
    required this.label,
    required this.selected,
    required this.scheme,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final ColorScheme scheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? scheme.primary : scheme.secondary;
    final fg = selected ? scheme.onPrimary : scheme.onSecondary;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(
        AppRadius.full(_kChipPickerMinHeight),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppRadius.full(_kChipPickerMinHeight),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: _kChipPickerMinHeight,
            maxHeight: _kChipPickerBarHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacings.xl,
              vertical: AppSpacings.s,
            ),
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: tagS.copyWith(color: fg),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
