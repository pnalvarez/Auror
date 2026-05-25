import 'package:auror/common/strings/guided_route_overview_strings.dart';
import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_ui.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GuidedSubmoduleEntryUI.fromDomain', () {
    test('maps unavailable entry to locked state', () {
      const domain = GuidedRouteSubmoduleEntryDomain(
        title: 'Guerras, golpes e a República',
        isConcluded: false,
        isAvailable: false,
      );

      final ui = GuidedSubmoduleEntryUI.fromDomain(domain, order: 3);
      final input = ui.listItemInput;

      expect(input.state, StepTitleSubtitleState.locked);
      expect(input.title, domain.title);
      expect(input.subtitle, guidedRouteOverviewCompletePreviousSubmodule);
      expect(input.stepNumber, isNull);
      expect(input.isListItemEnabled, isFalse);
    });

    test('maps available and not concluded entry to standard state with order', () {
      const domain = GuidedRouteSubmoduleEntryDomain(
        title: 'Açúcar, ouro e sangue',
        isConcluded: false,
        isAvailable: true,
      );

      final ui = GuidedSubmoduleEntryUI.fromDomain(domain, order: 2);
      final input = ui.listItemInput;

      expect(input.state, StepTitleSubtitleState.standard);
      expect(input.title, domain.title);
      expect(input.subtitle, guidedRouteOverviewSubmoduleAvailable);
      expect(input.stepNumber, 2);
      expect(input.isListItemEnabled, isTrue);
    });

    test('maps available and concluded entry to checked state', () {
      const domain = GuidedRouteSubmoduleEntryDomain(
        title: 'O Brasil que a escola pula',
        isConcluded: true,
        isAvailable: true,
      );

      final ui = GuidedSubmoduleEntryUI.fromDomain(domain, order: 1);
      final input = ui.listItemInput;

      expect(input.state, StepTitleSubtitleState.checked);
      expect(input.title, domain.title);
      expect(input.subtitle, guidedRouteOverviewSubmoduleConcluded);
      expect(input.stepNumber, isNull);
      expect(input.isListItemEnabled, isTrue);
    });

    test('treats unavailable as locked even when concluded', () {
      const domain = GuidedRouteSubmoduleEntryDomain(
        title: 'Locked but concluded',
        isConcluded: true,
        isAvailable: false,
      );

      final ui = GuidedSubmoduleEntryUI.fromDomain(domain, order: 4);

      expect(ui.listItemInput.state, StepTitleSubtitleState.locked);
      expect(ui.listItemInput.subtitle, guidedRouteOverviewCompletePreviousSubmodule);
    });
  });

  group('GuidedRouteModuleUI.fromDomain', () {
    test('maps module fields and submodule order from array position', () {
      const domain = GuidedRouteModuleDomain(
        title: 'História do Brasil',
        progress: 1,
        totalSubmodules: 3,
        submodules: [
          GuidedRouteSubmoduleEntryDomain(
            title: 'O Brasil que a escola pula',
            isConcluded: true,
            isAvailable: true,
          ),
          GuidedRouteSubmoduleEntryDomain(
            title: 'Açúcar, ouro e sangue',
            isConcluded: false,
            isAvailable: true,
          ),
          GuidedRouteSubmoduleEntryDomain(
            title: 'Guerras, golpes e a República',
            isConcluded: false,
            isAvailable: false,
          ),
        ],
      );

      final ui = GuidedRouteModuleUI.fromDomain(domain);
      final input = ui.listItemInput;

      expect(input.title, domain.title);
      expect(input.progress, domain.progress);
      expect(input.total, domain.totalSubmodules);
      expect(input.steps, hasLength(3));

      expect(input.steps[0].state, StepTitleSubtitleState.checked);
      expect(input.steps[0].title, domain.submodules[0].title);
      expect(input.steps[0].subtitle, guidedRouteOverviewSubmoduleConcluded);

      expect(input.steps[1].state, StepTitleSubtitleState.standard);
      expect(input.steps[1].title, domain.submodules[1].title);
      expect(input.steps[1].stepNumber, 2);
      expect(input.steps[1].subtitle, guidedRouteOverviewSubmoduleAvailable);

      expect(input.steps[2].state, StepTitleSubtitleState.locked);
      expect(input.steps[2].title, domain.submodules[2].title);
      expect(input.steps[2].stepNumber, isNull);
      expect(input.steps[2].subtitle, guidedRouteOverviewCompletePreviousSubmodule);
    });

    test('maps empty submodule list', () {
      const domain = GuidedRouteModuleDomain(
        title: 'Empty module',
        progress: 0,
        totalSubmodules: 0,
        submodules: [],
      );

      final ui = GuidedRouteModuleUI.fromDomain(domain);

      expect(ui.listItemInput.title, domain.title);
      expect(ui.listItemInput.steps, isEmpty);
    });
  });

  group('GuidedRouteOverviewUI.fromDomain', () {
    test('maps title, subtitle and module list item inputs', () {
      const domain = GuidedRouteOverviewDomain(
        title: 'História do Brasil',
        numberOfConcludedSubmodules: 1,
        modules: [
          GuidedRouteModuleDomain(
            title: 'Módulo 1',
            progress: 1,
            totalSubmodules: 2,
            submodules: [
              GuidedRouteSubmoduleEntryDomain(
                title: 'Submódulo 1',
                isConcluded: true,
                isAvailable: true,
              ),
              GuidedRouteSubmoduleEntryDomain(
                title: 'Submódulo 2',
                isConcluded: false,
                isAvailable: true,
              ),
            ],
          ),
          GuidedRouteModuleDomain(
            title: 'Módulo 2',
            progress: 0,
            totalSubmodules: 1,
            submodules: [
              GuidedRouteSubmoduleEntryDomain(
                title: 'Submódulo 3',
                isConcluded: false,
                isAvailable: false,
              ),
            ],
          ),
        ],
      );

      final ui = GuidedRouteOverviewUI.fromDomain(domain);

      expect(ui.title, domain.title);
      expect(
        ui.subtitle,
        guidedRouteOverviewModulesCompletedSubtitle(
          domain.numberOfConcludedSubmodules,
        ),
      );
      expect(ui.moduleListItemInputs, hasLength(2));

      expect(ui.moduleListItemInputs[0].title, domain.modules[0].title);
      expect(ui.moduleListItemInputs[0].progress, domain.modules[0].progress);
      expect(ui.moduleListItemInputs[0].total, domain.modules[0].totalSubmodules);
      expect(ui.moduleListItemInputs[0].steps, hasLength(2));
      expect(
        ui.moduleListItemInputs[0].steps[1].stepNumber,
        2,
      );

      expect(ui.moduleListItemInputs[1].title, domain.modules[1].title);
      expect(ui.moduleListItemInputs[1].steps, hasLength(1));
      expect(
        ui.moduleListItemInputs[1].steps[0].state,
        StepTitleSubtitleState.locked,
      );
    });

    test('maps empty modules list', () {
      const domain = GuidedRouteOverviewDomain(
        title: 'Empty route',
        numberOfConcludedSubmodules: 0,
        modules: [],
      );

      final ui = GuidedRouteOverviewUI.fromDomain(domain);

      expect(ui.title, domain.title);
      expect(ui.subtitle, '0 submódulos concluídos');
      expect(ui.moduleListItemInputs, isEmpty);
    });
  });
}
