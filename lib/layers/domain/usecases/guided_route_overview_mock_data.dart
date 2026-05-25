import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';

/// Mock guided route overview for development until API wiring exists.
const GuidedRouteOverviewDomain kMockGuidedRouteOverviewDomain =
    GuidedRouteOverviewDomain(
      title: 'História do Brasil',
      numberOfSubmodules: 1,
      modules: [
        GuidedRouteModuleDomain(
          title: 'História do Brasil',
          progress: 1,
          totalSubmodules: 5,
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
              title: 'A corte que fugiu e o Império improvável',
              isConcluded: false,
              isAvailable: false,
            ),
            GuidedRouteSubmoduleEntryDomain(
              title: 'As vozes que a história apagou',
              isConcluded: false,
              isAvailable: false,
            ),
            GuidedRouteSubmoduleEntryDomain(
              title: 'O Brasil que não acabou',
              isConcluded: false,
              isAvailable: false,
            ),
          ],
        ),
      ],
    );
