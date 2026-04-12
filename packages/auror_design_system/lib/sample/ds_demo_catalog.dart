import 'package:auror_design_system/sample/demos/badge_demo.dart';
import 'package:auror_design_system/sample/demos/chip_picker_demo.dart';
import 'package:auror_design_system/sample/demos/circular_loader_demo.dart';
import 'package:auror_design_system/sample/demos/colors_catalog_demo.dart';
import 'package:auror_design_system/sample/demos/disclaimer_card_demo.dart';
import 'package:auror_design_system/sample/demos/dropdown_demo.dart';
import 'package:auror_design_system/sample/demos/feedback_tile_demo.dart';
import 'package:auror_design_system/sample/demos/ds_action_buttons_demo.dart';
import 'package:auror_design_system/sample/demos/ds_snackbar_demo.dart';
import 'package:auror_design_system/sample/demos/input_field_demo.dart';
import 'package:auror_design_system/sample/demos/list_item_brands_demo.dart';
import 'package:auror_design_system/sample/demos/list_item_demo.dart';
import 'package:auror_design_system/sample/demos/list_item_icon_title_paragraph_demo.dart';
import 'package:auror_design_system/sample/demos/list_item_title_description_cta_progress_demo.dart';
import 'package:auror_design_system/sample/demos/media_backdrop_card_demo.dart';
import 'package:auror_design_system/sample/demos/navigation_bar_demo.dart';
import 'package:auror_design_system/sample/demos/profile_header_demo.dart';
import 'package:auror_design_system/sample/demos/recall_card_demo.dart';
import 'package:auror_design_system/sample/demos/score_tile_demo.dart';
import 'package:auror_design_system/sample/demos/status_chip_demo.dart';
import 'package:auror_design_system/sample/demos/step_progress_bar_demo.dart';
import 'package:auror_design_system/sample/demos/tooltip_demo.dart';
import 'package:auror_design_system/sample/demos/typography_catalog_demo.dart';
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
      'app_colors' => const DsDemoEntry(
        title: 'App colors',
        demo: ColorsCatalogDemo(),
      ),
      'badge' => const DsDemoEntry(
        title: 'Badge',
        demo: BadgeDemo(),
      ),
      'circular_loader' => const DsDemoEntry(
        title: 'Circular loader',
        demo: CircularLoaderDemo(),
      ),
      'chip_picker' => const DsDemoEntry(
        title: 'Chip picker',
        demo: ChipPickerDemo(),
      ),
      'disclaimer_card' => const DsDemoEntry(
        title: 'Disclaimer card',
        demo: DisclaimerCardDemo(),
      ),
      'dropdown' => const DsDemoEntry(
        title: 'Dropdown',
        demo: DropdownDemo(),
      ),
      'feedback_tile' => const DsDemoEntry(
        title: 'Feedback tile',
        demo: FeedbackTileDemo(),
      ),
      'input_field' => const DsDemoEntry(
        title: 'Input field',
        demo: InputFieldDemo(),
      ),
      'list_item' => const DsDemoEntry(
        title: 'List item',
        demo: ListItemDemo(),
      ),
      'list_item_brands' => const DsDemoEntry(
        title: 'List item · brands',
        demo: ListItemBrandsDemo(),
      ),
      'list_item_brand_neutral' => const DsDemoEntry(
        title: 'List item · neutral',
        demo: ListItemBrandNeutralCatalogDemo(),
      ),
      'list_item_brand_success' => const DsDemoEntry(
        title: 'List item · success',
        demo: ListItemBrandSuccessCatalogDemo(),
      ),
      'list_item_brand_warning' => const DsDemoEntry(
        title: 'List item · warning',
        demo: ListItemBrandWarningCatalogDemo(),
      ),
      'list_item_brand_error' => const DsDemoEntry(
        title: 'List item · error',
        demo: ListItemBrandErrorCatalogDemo(),
      ),
      'list_item_icon_title_paragraph' => const DsDemoEntry(
        title: 'List item · icon title paragraph',
        demo: ListItemIconTitleParagraphDemo(),
      ),
      'list_item_title_description_cta_progress' => const DsDemoEntry(
        title: 'List item · title description CTA progress',
        demo: ListItemTitleDescriptionCtaProgressDemo(),
      ),
      'media_backdrop_card' => const DsDemoEntry(
        title: 'Media backdrop card',
        demo: MediaBackdropCardDemo(),
      ),
      'navigation_bar' => const DsDemoEntry(
        title: 'Navigation bar',
        demo: NavigationBarDemo(),
      ),
      'profile_header' => const DsDemoEntry(
        title: 'Profile header',
        demo: ProfileHeaderDemo(),
      ),
      'recall_card' => const DsDemoEntry(
        title: 'Recall card',
        demo: RecallCardDemo(),
      ),
      'score_tile' => const DsDemoEntry(
        title: 'Score tile',
        demo: ScoreTileDemo(),
      ),
      'status_chip' => const DsDemoEntry(
        title: 'Status chip',
        demo: StatusChipDemo(),
      ),
      'step_progress_bar' => const DsDemoEntry(
        title: 'Step progress bar',
        demo: StepProgressBarDemo(),
      ),
      'tooltip' => const DsDemoEntry(
        title: 'Tooltip',
        demo: TooltipDemo(),
      ),
      'text_styles' => const DsDemoEntry(
        title: 'Text styles',
        demo: TypographyCatalogDemo(),
      ),
      'snackbar' => const DsDemoEntry(title: 'Snackbar', demo: SnackbarDemo()),
      _ => null,
    };
  }
}
