/// Guided route overview: modules and submodule progress (domain layer).
class GuidedRouteOverviewDomain {
  const GuidedRouteOverviewDomain({
    required this.title,
    required this.numberOfSubmodules,
    required this.modules,
  });

  final String title;
  final int numberOfSubmodules;
  final List<GuidedRouteModuleDomain> modules;
}

class GuidedRouteModuleDomain {
  const GuidedRouteModuleDomain({
    required this.title,
    required this.progress,
    required this.totalSubmodules,
    required this.submodules,
  });

  final String title;
  final int progress;
  final int totalSubmodules;
  final List<GuidedRouteSubmoduleEntryDomain> submodules;
}

class GuidedRouteSubmoduleEntryDomain {
  const GuidedRouteSubmoduleEntryDomain({
    required this.title,
    required this.isConcluded,
    required this.isAvailable,
  });

  final String title;
  final bool isConcluded;
  final bool isAvailable;
}
