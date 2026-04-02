import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/organisms/profile/profile_header.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

/// Showcases [ProfileHeader]: default avatar, network image, and failed load.
class ProfileHeaderDemo extends StatelessWidget {
  const ProfileHeaderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Centered profile block: optional image URL, name, and email. '
                'Missing URL, load error, or loading state uses the design-system '
                'placeholder (dark navy surface + gold accent).',
                style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacings.xl2),
              Text('Default (no image URL)', style: headlineS),
              const SizedBox(height: AppSpacings.m),
              const ProfileHeader(
                name: 'Pedro Alvarez',
                email: 'ios.palvarez@gmail.com',
              ),
              const SizedBox(height: AppSpacings.xl3),
              Text('Network image', style: headlineS),
              const SizedBox(height: AppSpacings.m),
              const ProfileHeader(
                imageUrl: 'https://picsum.photos/seed/auror-profile/256',
                name: 'Pedro Alvarez',
                email: 'ios.palvarez@gmail.com',
              ),
              const SizedBox(height: AppSpacings.xl3),
              Text('Invalid URL (fallback placeholder)', style: headlineS),
              const SizedBox(height: AppSpacings.m),
              const ProfileHeader(
                imageUrl: 'https://invalid.url.example/404.png',
                name: 'Pedro Alvarez',
                email: 'ios.palvarez@gmail.com',
              ),
            ],
          );
        },
      ),
    );
  }
}
