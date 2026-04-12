import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DsMenuSamplePage extends StatelessWidget {
  const DsMenuSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: scheme.surface,
            appBar: AppBar(
              backgroundColor: scheme.surface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              title: const Text('Design system'),
            ),
            body: ListView(
              padding: const EdgeInsets.all(AppSpacings.xl2),
              children: [
                PrimaryButton(
                  label: 'Action buttons',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'action_buttons'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Badge',
                  brand: ButtonBrand.primary,
                  action: () =>
                      context.router.push(DSComponentRoute(demoId: 'badge')),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Circular loader',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'circular_loader'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Chip picker',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'chip_picker'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Disclaimer card',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'disclaimer_card'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Dropdown',
                  brand: ButtonBrand.primary,
                  action: () =>
                      context.router.push(DSComponentRoute(demoId: 'dropdown')),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Feedback tile',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'feedback_tile'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Input field',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'input_field'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'list_item'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item · brands',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'list_item_brands'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item · neutral',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'list_item_brand_neutral'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item · success',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'list_item_brand_success'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item · warning',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'list_item_brand_warning'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item · error',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'list_item_brand_error'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item · icon title paragraph',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'list_item_icon_title_paragraph'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'List item · title description CTA progress',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(
                      demoId: 'list_item_title_description_cta_progress',
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Media backdrop card',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'media_backdrop_card'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Navigation bar',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'navigation_bar'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Recall card',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'recall_card'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Score tile',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'score_tile'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Profile header',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'profile_header'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Status chip',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'status_chip'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Step progress bar',
                  brand: ButtonBrand.primary,
                  action: () => context.router.push(
                    DSComponentRoute(demoId: 'step_progress_bar'),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Tooltip',
                  brand: ButtonBrand.primary,
                  action: () =>
                      context.router.push(DSComponentRoute(demoId: 'tooltip')),
                ),
                const SizedBox(height: AppSpacings.m),
                PrimaryButton(
                  label: 'Snackbar',
                  brand: ButtonBrand.primary,
                  action: () =>
                      context.router.push(DSComponentRoute(demoId: 'snackbar')),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
