// ignore_for_file: avoid_print

import 'dart:io';

/// Scaffolds a presentation screen folder under
/// `lib/layers/presentation/screens/<folder>/` with page, body, view model,
/// state, and event files.
///
/// Usage:
///   dart run tool/create_screen_template.dart <screen_name>
///
/// Examples:
///   dart run tool/create_screen_template.dart guided_route_detail
///   dart run tool/create_screen_template.dart GuidedRouteDetail
///   dart run tool/create_screen_template.dart guided-route-detail
///
/// After generation, run:
///   dart run build_runner build --delete-conflicting-outputs
void main(List<String> args) {
  if (args.isEmpty || args.contains('-h') || args.contains('--help')) {
    _printUsage();
    exit(args.isEmpty ? 64 : 0);
  }

  final rawName = args.first.trim();
  if (rawName.isEmpty) {
    stderr.writeln('Error: screen name cannot be empty.');
    _printUsage();
    exit(64);
  }

  final folderName = _toFolderName(rawName);
  final filePrefix = _toSnakeCase(rawName);
  final classPrefix = _toPascalCase(rawName);

  if (!RegExp(r'^[a-z][a-z0-9]*$').hasMatch(folderName)) {
    stderr.writeln('Error: invalid screen name "$rawName".');
    exit(64);
  }

  final screenDir = Directory(
    'lib/layers/presentation/screens/$folderName',
  );
  if (screenDir.existsSync()) {
    stderr.writeln(
      'Error: screen folder already exists: ${screenDir.path}',
    );
    exit(1);
  }

  screenDir.createSync(recursive: true);

  final importBase =
      'package:auror/layers/presentation/screens/$folderName';

  final files = <String, String>{
    '$filePrefix\_page.dart': _pageTemplate(
      importBase: importBase,
      filePrefix: filePrefix,
      classPrefix: classPrefix,
    ),
    '$filePrefix\_body.dart': _bodyTemplate(
      classPrefix: classPrefix,
    ),
    '$filePrefix\_view_model.dart': _viewModelTemplate(
      importBase: importBase,
      filePrefix: filePrefix,
      classPrefix: classPrefix,
    ),
    '$filePrefix\_state.dart': _stateTemplate(
      filePrefix: filePrefix,
      classPrefix: classPrefix,
    ),
    '$filePrefix\_event.dart': _eventTemplate(
      filePrefix: filePrefix,
      classPrefix: classPrefix,
    ),
  };

  for (final entry in files.entries) {
    final file = File('${screenDir.path}/${entry.key}');
    file.writeAsStringSync('${entry.value}\n');
    stdout.writeln('Created ${file.path}');
  }

  stdout.writeln('');
  stdout.writeln('Screen "$classPrefix" scaffolded at ${screenDir.path}.');
  stdout.writeln('Next steps:');
  stdout.writeln('  1. dart run build_runner build --delete-conflicting-outputs');
  stdout.writeln('  2. Register ${classPrefix}Page in app_router.dart');
  stdout.writeln('  3. Wire ${classPrefix}ViewModel dependencies in DI');
}

void _printUsage() {
  stdout.writeln('''
Usage: dart run tool/create_screen_template.dart <screen_name>

Creates:
  lib/layers/presentation/screens/<folder>/
    <snake_case>_page.dart
    <snake_case>_body.dart
    <snake_case>_view_model.dart
    <snake_case>_state.dart
    <snake_case>_event.dart

<screen_name> accepts snake_case, kebab-case, or PascalCase.
''');
}

String _toFolderName(String input) {
  return input.replaceAll(RegExp(r'[\s_-]+'), '').toLowerCase();
}

String _toSnakeCase(String input) {
  final normalized = input.trim().replaceAll(RegExp(r'[\s-]+'), '_');
  if (normalized.contains('_')) {
    return normalized
        .split('_')
        .where((part) => part.isNotEmpty)
        .map((part) => part.toLowerCase())
        .join('_');
  }

  return normalized
      .replaceAllMapped(
        RegExp(r'([a-z0-9])([A-Z])'),
        (match) => '${match[1]}_${match[2]}',
      )
      .replaceAllMapped(
        RegExp(r'([A-Z]+)([A-Z][a-z])'),
        (match) => '${match[1]}_${match[2]}',
      )
      .toLowerCase();
}

String _toPascalCase(String input) {
  return _toSnakeCase(input)
      .split('_')
      .where((part) => part.isNotEmpty)
      .map(
        (part) => part.length == 1
            ? part.toUpperCase()
            : '${part[0].toUpperCase()}${part.substring(1)}',
      )
      .join();
}

String _pageTemplate({
  required String importBase,
  required String filePrefix,
  required String classPrefix,
}) {
  return '''
import 'package:auror/common/utils/app_themed_page.dart';
import 'package:auror/core/di/di.dart';
import '$importBase/${filePrefix}_body.dart';
import '$importBase/${filePrefix}_event.dart';
import '$importBase/${filePrefix}_state.dart';
import '$importBase/${filePrefix}_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// TODO: document ${classPrefix}Page.
@RoutePage()
class ${classPrefix}Page extends StatelessWidget {
  const ${classPrefix}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<${classPrefix}ViewModel>()
            ..add(const ${classPrefix}Event.loadRequested()),
      child: BlocBuilder<${classPrefix}ViewModel, ${classPrefix}State>(
        builder: (context, state) {
          return AppThemedPage(
            child: ${classPrefix}Body(
              isLoading: state.isLoading,
              errorMessage: state.errorMessage,
            ),
          );
        },
      ),
    );
  }
}
''';
}

String _bodyTemplate({
  required String classPrefix,
}) {
  return '''
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:flutter/material.dart';

/// UI for [${classPrefix}Page]. Navigation and side effects stay in the page.
class ${classPrefix}Body extends StatelessWidget {
  const ${classPrefix}Body({
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
        child: Text('TODO: ${classPrefix} content'),
      ),
    );
  }
}
''';
}

String _viewModelTemplate({
  required String importBase,
  required String filePrefix,
  required String classPrefix,
}) {
  return '''
import '$importBase/${filePrefix}_event.dart';
import '$importBase/${filePrefix}_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ${classPrefix}ViewModel extends Bloc<${classPrefix}Event, ${classPrefix}State> {
  ${classPrefix}ViewModel() : super(const ${classPrefix}State()) {
    on<${classPrefix}LoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    ${classPrefix}LoadRequested event,
    Emitter<${classPrefix}State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      // TODO: load data via use cases.
      emit(state.copyWith(isLoading: false, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
''';
}

String _stateTemplate({
  required String filePrefix,
  required String classPrefix,
}) {
  return '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '${filePrefix}_state.freezed.dart';

@freezed
sealed class ${classPrefix}State with _\$${classPrefix}State {
  const factory ${classPrefix}State({
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _${classPrefix}State;
}
''';
}

String _eventTemplate({
  required String filePrefix,
  required String classPrefix,
}) {
  return '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '${filePrefix}_event.freezed.dart';

@freezed
sealed class ${classPrefix}Event with _\$${classPrefix}Event {
  const factory ${classPrefix}Event.loadRequested() = ${classPrefix}LoadRequested;
}
''';
}
