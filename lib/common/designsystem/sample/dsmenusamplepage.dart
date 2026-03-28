import 'package:auto_route/auto_route.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DsMenuSamplePage extends StatelessWidget {
  const DsMenuSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design system')),
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
            label: 'Circular loader',
            brand: ButtonBrand.primary,
            action: () => context.router.push(
              DSComponentRoute(demoId: 'circular_loader'),
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
            label: 'Recall card',
            brand: ButtonBrand.primary,
            action: () => context.router.push(
              DSComponentRoute(demoId: 'recall_card'),
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
        ],
      ),
    );
  }
}
