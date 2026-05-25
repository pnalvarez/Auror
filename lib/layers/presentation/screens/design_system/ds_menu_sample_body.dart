import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:flutter/material.dart';

/// Design-system demo launcher list for [DsMenuSamplePage].
class DsMenuSampleBody extends StatelessWidget {
  const DsMenuSampleBody({super.key, required this.onDemoSelected});

  final ValueChanged<String> onDemoSelected;

  static const List<(String label, String demoId)> _demos = [
    ('Action buttons', 'action_buttons'),
    ('App colors', 'app_colors'),
    ('Icons', 'app_icons'),
    ('Text styles', 'text_styles'),
    ('Badge', 'badge'),
    ('Circular loader', 'circular_loader'),
    ('Shimmer rectangle', 'shimmer_rectangle'),
    ('Chip picker', 'chip_picker'),
    ('Disclaimer card', 'disclaimer_card'),
    ('Dropdown', 'dropdown'),
    ('Feedback tile', 'feedback_tile'),
    ('Input field', 'input_field'),
    ('List item', 'list_item'),
    ('List item · brands', 'list_item_brands'),
    ('List item · neutral', 'list_item_brand_neutral'),
    ('List item · success', 'list_item_brand_success'),
    ('List item · warning', 'list_item_brand_warning'),
    ('List item · error', 'list_item_brand_error'),
    ('List item · icon title paragraph', 'list_item_icon_title_paragraph'),
    (
      'List item · title description CTA progress',
      'list_item_title_description_cta_progress',
    ),
    (
      'List item · title description checkpoints',
      'list_item_title_description_checkpoints',
    ),
    ('Media backdrop card', 'media_backdrop_card'),
    ('Navigation bar', 'navigation_bar'),
    ('Recall card', 'recall_card'),
    ('Score tile', 'score_tile'),
    ('Profile header', 'profile_header'),
    ('Status chip', 'status_chip'),
    ('Step progress bar', 'step_progress_bar'),
    ('Tooltip', 'tooltip'),
    ('Snackbar', 'snackbar'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacings.xl2),
      children: [
        for (var i = 0; i < _demos.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacings.m),
          PrimaryButton(
            label: _demos[i].$1,
            brand: ButtonBrand.primary,
            action: () => onDemoSelected(_demos[i].$2),
          ),
        ],
      ],
    );
  }
}
