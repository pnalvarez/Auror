import 'package:auror/layers/presentation/screens/home/home_event.dart';
import 'package:auror/layers/presentation/screens/home/home_page_body.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'stub_home_view_model.dart';

@widgetbook.UseCase(
  name: 'With sample data',
  type: HomePageBody,
  path: '[Auror]/[Screens]/Home',
)
Widget homePageWithSampleData(BuildContext context) {
  return BlocProvider<StubHomeViewModel>(
    create: (_) => StubHomeViewModel()..add(HomeEvent.started()),
    child: BlocBuilder<StubHomeViewModel, HomeState>(
      builder: (context, state) {
        return HomePageBody(
          state: state,
          onSeeMoreRevisions: () {},
        );
      },
    ),
  );
}
