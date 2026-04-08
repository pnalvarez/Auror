import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/dropdown/ds_dropdown.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

/// Showcases [DsDropdown]: label row with chevron and expandable body.
class DropdownDemo extends StatelessWidget {
  const DropdownDemo({super.key});

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
                'Tap the row to expand or collapse. The chevron points right when '
                'collapsed and down when open.',
                style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacings.xl2),
              DsDropdown(
                label: 'Detalhes da trilha',
                child: Text(
                  'Conteúdo opcional: descrição longa, lista de tópicos, ou qualquer '
                  'widget filho.',
                  style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: AppSpacings.xl),
              DsDropdown(
                label: 'Outro bloco',
                initiallyExpanded: true,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacings.m),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppRadius.m),
                  ),
                  child: Text(
                    'Exemplo com container e padding.',
                    style: body2Medium.copyWith(color: scheme.onSurface),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
