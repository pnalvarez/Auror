import 'package:auror/common/strings/guided_route_overview_strings.dart';
import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';

/// Presentation row for a guided route submodule, mapped from
/// [GuidedRouteSubmoduleEntryDomain].
class GuidedSubmoduleEntryUI {
  const GuidedSubmoduleEntryUI({required this.listItemInput});

  final StepTitleSubtitleInput listItemInput;

  factory GuidedSubmoduleEntryUI.fromDomain(
    GuidedRouteSubmoduleEntryDomain domain, {
    required int order,
  }) {
    if (!domain.isAvailable) {
      return GuidedSubmoduleEntryUI(
        listItemInput: StepTitleSubtitleInput(
          state: StepTitleSubtitleState.locked,
          title: domain.title,
          subtitle: guidedRouteOverviewCompletePreviousSubmodule,
        ),
      );
    }
    if (!domain.isConcluded) {
      return GuidedSubmoduleEntryUI(
        listItemInput: StepTitleSubtitleInput(
          state: StepTitleSubtitleState.standard,
          stepNumber: order,
          title: domain.title,
          subtitle: guidedRouteOverviewSubmoduleAvailable,
        ),
      );
    }
    return GuidedSubmoduleEntryUI(
      listItemInput: StepTitleSubtitleInput(
        state: StepTitleSubtitleState.checked,
        title: domain.title,
        subtitle: guidedRouteOverviewSubmoduleConcluded,
      ),
    );
  }
}

/// Presentation card for a guided route module, mapped from [GuidedRouteModuleDomain].
class GuidedRouteModuleUI {
  const GuidedRouteModuleUI({required this.listItemInput});

  final TitleProgressStepsInput listItemInput;

  factory GuidedRouteModuleUI.fromDomain(GuidedRouteModuleDomain domain) {
    return GuidedRouteModuleUI(
      listItemInput: TitleProgressStepsInput(
        title: domain.title,
        progress: domain.progress,
        total: domain.totalSubmodules,
        steps: [
          for (var i = 0; i < domain.submodules.length; i++)
            GuidedSubmoduleEntryUI.fromDomain(
              domain.submodules[i],
              order: i + 1,
            ).listItemInput,
        ],
      ),
    );
  }
}

/// Presentation model for a guided route overview, mapped from
/// [GuidedRouteOverviewDomain].
class GuidedRouteOverviewUI {
  const GuidedRouteOverviewUI({
    required this.title,
    required this.subtitle,
    required this.moduleListItemInputs,
  });

  final String title;
  final String subtitle;
  final List<TitleProgressStepsInput> moduleListItemInputs;

  factory GuidedRouteOverviewUI.fromDomain(GuidedRouteOverviewDomain domain) {
    return GuidedRouteOverviewUI(
      title: domain.title,
      subtitle: guidedRouteOverviewModulesCompletedSubtitle(
        domain.numberOfConcludedSubmodules,
      ),
      moduleListItemInputs: [
        for (final module in domain.modules)
          GuidedRouteModuleUI.fromDomain(module).listItemInput,
      ],
    );
  }
}
