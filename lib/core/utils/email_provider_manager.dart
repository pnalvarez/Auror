import 'package:url_launcher/url_launcher.dart';

class EmailProviderTarget {
  const EmailProviderTarget({
    required this.ctaLabel,
    required this.launchUri,
    required this.fallbackUri,
  });

  final String ctaLabel;
  final Uri launchUri;
  final Uri fallbackUri;
}

class EmailProviderManager {
  const EmailProviderManager._();

  static EmailProviderTarget targetForEmail(String email) {
    final domain = _providerDomain(email);
    if (domain.contains('gmail.com')) {
      return EmailProviderTarget(
        ctaLabel: 'Abrir Gmail',
        launchUri: Uri.parse('googlegmail://'),
        fallbackUri: Uri.parse('https://mail.google.com/'),
      );
    }
    if (domain.contains('outlook.') ||
        domain.contains('hotmail.') ||
        domain.contains('live.')) {
      return EmailProviderTarget(
        ctaLabel: 'Abrir Outlook',
        launchUri: Uri.parse('ms-outlook://'),
        fallbackUri: Uri.parse('https://outlook.live.com/mail/'),
      );
    }
    if (domain.contains('yahoo.')) {
      return EmailProviderTarget(
        ctaLabel: 'Abrir Yahoo Mail',
        launchUri: Uri.parse('ymail://'),
        fallbackUri: Uri.parse('https://mail.yahoo.com/'),
      );
    }

    return EmailProviderTarget(
      ctaLabel: 'Abrir e-mail',
      launchUri: Uri.parse('message://'),
      fallbackUri: Uri.parse('mailto:'),
    );
  }

  static Future<void> openEmailProvider(String email) async {
    final target = targetForEmail(email);
    if (await canLaunchUrl(target.launchUri)) {
      await launchUrl(target.launchUri, mode: LaunchMode.externalApplication);
      return;
    }
    await launchUrl(target.fallbackUri, mode: LaunchMode.externalApplication);
  }

  static String _providerDomain(String email) {
    final normalized = email.trim().toLowerCase();
    final atIndex = normalized.lastIndexOf('@');
    if (atIndex < 0 || atIndex == normalized.length - 1) {
      return '';
    }
    return normalized.substring(atIndex + 1);
  }
}
