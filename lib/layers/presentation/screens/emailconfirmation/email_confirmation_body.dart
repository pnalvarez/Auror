import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:flutter/material.dart';

/// Bottom CTA for [EmailConfirmationPage]. Side effects live in the page.
class EmailConfirmationBody extends StatelessWidget {
  const EmailConfirmationBody({
    super.key,
    required this.ctaLabel,
    required this.onOpenMailbox,
  });

  final String ctaLabel;
  final VoidCallback onOpenMailbox;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            label: ctaLabel,
            isExpanded: true,
            action: onOpenMailbox,
          ),
        ),
      ],
    );
  }
}
