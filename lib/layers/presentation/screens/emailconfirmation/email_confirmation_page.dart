import 'package:auror/common/utils/app_themed_page.dart';
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

  String get _providerDomain {
    final normalized = email.trim().toLowerCase();
    final atIndex = normalized.lastIndexOf('@');
    if (atIndex < 0 || atIndex == normalized.length - 1) {
      return '';
    }
    return normalized.substring(atIndex + 1);
  }

  _EmailProviderTarget get _providerTarget {
    final domain = _providerDomain;
    if (domain.contains('gmail.com')) {
      return _EmailProviderTarget(
        ctaLabel: 'Abrir Gmail',
        launchUri: Uri.parse('googlegmail://'),
        fallbackUri: Uri.parse('https://mail.google.com/'),
      );
    }
    if (domain.contains('outlook.') ||
        domain.contains('hotmail.') ||
        domain.contains('live.')) {
      return _EmailProviderTarget(
        ctaLabel: 'Abrir Outlook',
        launchUri: Uri.parse('ms-outlook://'),
        fallbackUri: Uri.parse('https://outlook.live.com/mail/'),
      );
    }
    if (domain.contains('yahoo.')) {
      return _EmailProviderTarget(
        ctaLabel: 'Abrir Yahoo Mail',
        launchUri: Uri.parse('ymail://'),
        fallbackUri: Uri.parse('https://mail.yahoo.com/'),
      );
    }

    return _EmailProviderTarget(
      ctaLabel: 'Abrir e-mail',
      launchUri: Uri.parse('message://'),
      fallbackUri: Uri.parse('mailto:'),
    );
  }

  Future<void> _openEmailProvider(BuildContext context) async {
    final target = _providerTarget;
    if (await canLaunchUrl(target.launchUri)) {
      await launchUrl(target.launchUri, mode: LaunchMode.externalApplication);
      return;
    }
    await launchUrl(target.fallbackUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final target = _providerTarget;

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

class _EmailProviderTarget {
  const _EmailProviderTarget({
    required this.ctaLabel,
    required this.launchUri,
    required this.fallbackUri,
  });

  final String ctaLabel;
  final Uri launchUri;
  final Uri fallbackUri;
}
