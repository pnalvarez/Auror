import 'package:auror/common/utils/app_themed_page.dart';
import 'package:auror/core/utils/email_provider_manager.dart';
import 'package:auror/layers/presentation/screens/emailconfirmation/email_confirmation_body.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
        body: EmailConfirmationBody(
          ctaLabel: target.ctaLabel,
          onOpenMailbox: () => _openEmailProvider(context),
        ),
      ),
    );
  }
}
