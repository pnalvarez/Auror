import 'package:auror/common/utils/app_themed_page.dart';
import 'package:auror/core/utils/email_provider_manager.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class EmailConfirmationPage extends StatelessWidget {
  const EmailConfirmationPage({super.key, required this.email});

  final String email;

  Future<void> _openEmailProvider(BuildContext context) async {
    await EmailProviderManager.openEmailProvider(email);
  }

  @override
  Widget build(BuildContext context) {
    final target = EmailProviderManager.targetForEmail(email);

    return AppThemedPage(
      child: Scaffold(
        appBar: DsNavigationBar(
          leadingIcon: Icons.arrow_back,
          title: 'Confirme seu e-mail',
          description:
              'Entre no seu aplicativo de e-mail e clique no link de confirmação para ativar sua conta.',
          onLeadingTap: () => context.router.maybePop(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacings.xl2,
                left: AppSpacings.l,
                right: AppSpacings.l,
              ),
              child: PrimaryButton(
                label: target.ctaLabel,
                isExpanded: true,
                action: () => _openEmailProvider(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
