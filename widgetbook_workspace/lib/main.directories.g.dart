// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_workspace/app_use_cases.dart'
    as _widgetbook_workspace_app_use_cases;
import 'package:widgetbook_workspace/design_system_use_cases.dart'
    as _widgetbook_workspace_design_system_use_cases;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'Auror',
    children: [
      _widgetbook.WidgetbookCategory(
        name: 'Screens',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'Home',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'HomePageBody',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'With sample data',
                    builder: _widgetbook_workspace_app_use_cases
                        .homePageWithSampleData,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'Subscription upgrade',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'SubscriptionUpgradePage',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder: _widgetbook_workspace_app_use_cases
                        .subscriptionUpgradeDefault,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookCategory(
    name: 'Design System',
    children: [
      _widgetbook.WidgetbookCategory(
        name: 'Molecules',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'DsBadge',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'DsBadge',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder: _widgetbook_workspace_design_system_use_cases
                        .dsBadgeInteractive,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'InputField',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'InputField',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder: _widgetbook_workspace_design_system_use_cases
                        .inputFieldInteractive,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'PrimaryButton',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'PrimaryButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder: _widgetbook_workspace_design_system_use_cases
                        .primaryButtonInteractive,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'RecallCard',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'RecallCard',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder: _widgetbook_workspace_design_system_use_cases
                        .recallCardInteractive,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'SecondaryButton',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'SecondaryButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder: _widgetbook_workspace_design_system_use_cases
                        .secondaryButtonInteractive,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'StatusChip',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'StatusChip',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder: _widgetbook_workspace_design_system_use_cases
                        .statusChipInteractive,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
