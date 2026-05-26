import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:flutter/material.dart';

/// UI for [KnowledgeCardPage]. Navigation and side effects stay in the page.
class KnowledgeCardBody extends StatelessWidget {
  const KnowledgeCardBody({
    super.key,
    required this.isLoading,
    this.errorMessage,
  });

  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: scheme.primary),
      );
    }
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl2),
          child: Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const DsNavigationBar(
        title: 'TODO: title',
        description: 'TODO: description',
      ),
      body: const Center(
        child: Text('TODO: KnowledgeCard content'),
      ),
    );
  }
}

