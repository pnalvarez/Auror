import 'package:auror/common/utils/app_themed_page.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_body.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_event.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_state.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class KnowledgeCardPage extends StatelessWidget {
  const KnowledgeCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<KnowledgeCardViewModel>()
            ..add(const KnowledgeCardEvent.loadRequested()),
      child: BlocBuilder<KnowledgeCardViewModel, KnowledgeCardState>(
        builder: (context, state) {
          return AppThemedPage(
            child: KnowledgeCardBody(
              isLoading: state.isLoading,
              errorMessage: state.errorMessage,
            ),
          );
        },
      ),
    );
  }
}
