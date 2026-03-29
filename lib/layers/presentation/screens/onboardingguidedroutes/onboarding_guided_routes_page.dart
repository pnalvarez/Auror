import 'package:auto_route/auto_route.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/common/designsystem/molecules/cards/content_card.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/guided_routes_strings.dart';
import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingGuidedRoutesPage extends StatelessWidget {
  const OnboardingGuidedRoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: const _OnboardingGuidedRoutesContent(),
    );
  }
}

class _OnboardingGuidedRoutesContent extends StatelessWidget {
  const _OnboardingGuidedRoutesContent();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacings.xl,
                  AppSpacings.m,
                  AppSpacings.xl,
                  AppSpacings.l,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      guidedRoutesTitle,
                      style: headlineXs.copyWith(
                        color: scheme.onSurface,
                        height: 1.22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.s),
                    Text(
                      guidedRoutesSubtitle,
                      style: body2Light.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.xl2),
                    ContentCard.listTile(
                      tileIcon: const Icon(Icons.map_outlined),
                      itemTitle: routeAutoliderancaTitle,
                      itemDescription: routeAutoliderancaDescription,
                    ),
                    const SizedBox(height: AppSpacings.l),
                    ContentCard.listTile(
                      tileIcon: const Icon(Icons.bolt_rounded),
                      itemTitle: routeProdutividadeTitle,
                      itemDescription: routeProdutividadeDescription,
                    ),
                    const SizedBox(height: AppSpacings.l),
                    ContentCard.listTile(
                      tileIcon: const Icon(Icons.psychology_outlined),
                      itemTitle: routeIeTitle,
                      itemDescription: routeIeDescription,
                    ),
                    const SizedBox(height: AppSpacings.l),
                    ContentCard.listTile(
                      tileIcon: const Icon(Icons.chat_bubble_outline_rounded),
                      itemTitle: routeComunicacaoTitle,
                      itemDescription: routeComunicacaoDescription,
                    ),
                    const SizedBox(height: AppSpacings.xl2),
                    ContentCard.listTileCustom(
                      tileIcon: const Icon(Icons.explore_outlined),
                      body: Text.rich(
                        TextSpan(
                          style: body4Light.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.45,
                          ),
                          children: [
                            const TextSpan(text: guidedRoutesExploreLead),
                            TextSpan(
                              text: guidedRoutesExploreHighlight,
                              style: body4Light.copyWith(
                                color: scheme.onSurface,
                                fontWeight: FontWeight.w600,
                                height: 1.45,
                              ),
                            ),
                            TextSpan(text: guidedRoutesExploreTail),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacings.xl,
                AppSpacings.s,
                AppSpacings.xl,
                AppSpacings.xl,
              ),
              child: PrimaryButton(
                label: ctaEnterApp,
                brand: ButtonBrand.primary,
                action: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
