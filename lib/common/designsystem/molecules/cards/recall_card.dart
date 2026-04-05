import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/common/designsystem/molecules/cards/feedback_tile.dart';
import 'package:auror/common/designsystem/molecules/chips/status_chip.dart';
import 'package:flutter/material.dart';

/// User self-rating after revealing the expected answer.
enum RecallFeedbackKind { didNotRemember, partial, remembered }

/// Flashcard-style recall: topic pill, question copy, then [expectedAnswer] after
/// "Ver resposta". Fixed labels for the answer block and feedback row; tiles match
/// [FeedbackTile] semantics (error / warning / success).
class RecallCard extends StatefulWidget {
  const RecallCard({
    super.key,
    required this.topic,
    required this.title,
    required this.description,
    required this.expectedAnswer,
    this.onFeedback,
    this.onReveal,
    this.onTapError,
    this.onTapWarning,
    this.onTapSuccess,
    this.initialRevealed = false,
    this.topicChipState = StatusChipState.neutral,
  });

  final String topic;
  final String title;
  final String description;
  final String expectedAnswer;

  /// Called when the user taps one of the three fixed feedback tiles.
  final void Function(RecallFeedbackKind kind)? onFeedback;
  final void Function()? onReveal;
  final void Function()? onTapError;
  final void Function()? onTapWarning;
  final void Function()? onTapSuccess;

  /// When true, the expected answer and feedback row show immediately (e.g. onboarding demo).
  final bool initialRevealed;

  /// Visual accent for the topic pill (default neutral).
  final StatusChipState topicChipState;

  /// Fixed UI copy (Portuguese).
  static const String expectedAnswerTitle = 'Resposta esperada';
  static const String feedbackPrompt = 'O quanto você lembrou?';
  static const String revealAnswerLabel = 'Ver resposta';

  @override
  State<RecallCard> createState() => _RecallCardState();
}

class _RecallCardState extends State<RecallCard> {
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _revealed = widget.initialRevealed;
  }

  void _onReveal() {
    setState(() {
      _revealed = true;
      widget.onReveal?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final titleStyle = headlineS.copyWith(
      color: scheme.onSurface,
      height: 1.25,
    );
    final descriptionStyle = body3Light.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.45,
    );

    final outline = scheme.outline.withValues(alpha: 0.35);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.l),
        border: Border.all(color: outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: StatusChip(
                label: widget.topic,
                state: widget.topicChipState,
                hasDot: false,
              ),
            ),
            const SizedBox(height: AppSpacings.m),
            Text(widget.title, style: titleStyle),
            const SizedBox(height: AppSpacings.s),
            Text(widget.description, style: descriptionStyle),
            if (!_revealed) ...[
              const SizedBox(height: AppSpacings.xl),
              PrimaryButton(
                label: RecallCard.revealAnswerLabel,
                action: _onReveal,
                brand: ButtonBrand.secondary,
              ),
            ] else ...[
              const SizedBox(height: AppSpacings.xl),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppRadius.m),
                  border: Border.all(color: outline),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacings.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        RecallCard.expectedAnswerTitle,
                        style: tagS.copyWith(
                          color: scheme.onSurfaceVariant,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.s),
                      Text(
                        widget.expectedAnswer,
                        style: body3Light.copyWith(
                          color: scheme.onSurface,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.xl),
                      Text(
                        RecallCard.feedbackPrompt,
                        textAlign: TextAlign.center,
                        style: body3Light.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.m),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          const gap = AppSpacings.s;
                          final tileW = (constraints.maxWidth - gap * 2) / 3;
                          final h = (tileW * 1.12).clamp(96.0, 132.0);
                          Widget tile({
                            required FeedbackTileState state,
                            required String title,
                            required String subtitle,
                            required RecallFeedbackKind kind,
                            required void Function()? onTap,
                          }) {
                            return Expanded(
                              child: FeedbackTile(
                                state: state,
                                title: title,
                                subtitle: subtitle,
                                onTap: () {
                                  onTap?.call();
                                },
                              ),
                            );
                          }

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tile(
                                state: FeedbackTileState.error,
                                title: 'Não lembrei',
                                subtitle: 'D+1',
                                kind: RecallFeedbackKind.didNotRemember,
                                onTap: widget.onTapError,
                              ),
                              const SizedBox(width: gap),
                              tile(
                                state: FeedbackTileState.warning,
                                title: 'Parcial',
                                subtitle: 'D+3',
                                kind: RecallFeedbackKind.partial,
                                onTap: widget.onTapWarning,
                              ),
                              const SizedBox(width: gap),
                              tile(
                                state: FeedbackTileState.success,
                                title: 'Lembrei!',
                                subtitle: 'D+7',
                                kind: RecallFeedbackKind.remembered,
                                onTap: widget.onTapSuccess,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
