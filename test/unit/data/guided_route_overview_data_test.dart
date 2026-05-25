import 'package:auror/layers/data/models/guided_route_overview_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GuidedRouteSubmoduleData.fromJson', () {
    test('reads progress from embedded user_submodule_progress', () {
      final data = GuidedRouteSubmoduleData.fromJson({
        'name': 'Civilizações fundadoras',
        'user_submodule_progress': [
          {'has_finished': false, 'is_available': true},
        ],
      });

      expect(data.title, 'Civilizações fundadoras');
      expect(data.isConcluded, isFalse);
      expect(data.isAvailable, isTrue);
    });

    test('reads flat has_finished and is_available', () {
      final data = GuidedRouteSubmoduleData.fromJson({
        'title': 'A virada moderna',
        'has_finished': true,
        'is_available': false,
      });

      expect(data.title, 'A virada moderna');
      expect(data.isConcluded, isTrue);
      expect(data.isAvailable, isFalse);
    });
  });

  group('GuidedRouteModuleData.fromJson', () {
    test('maps module name and computes progress from submodules', () {
      final data = GuidedRouteModuleData.fromJson({
        'id': 'mod-1',
        'name': 'História do mundo',
        'submodules': [
          {
            'name': 'A',
            'has_finished': true,
            'is_available': true,
          },
          {
            'name': 'B',
            'has_finished': false,
            'is_available': false,
          },
        ],
      });

      expect(data.id, 'mod-1');
      expect(data.title, 'História do mundo');
      expect(data.progress, 1);
      expect(data.totalSubmodules, 2);
      expect(data.submodules, hasLength(2));
    });
  });

  group('GuidedRouteOverviewData.fromJson', () {
    test('parses route overview and maps to domain', () {
      final data = GuidedRouteOverviewData.fromJson({
        'id': '6ce95aac-c099-45f8-b3ad-2600ddf79356',
        'name': 'História',
        'modules': [
          {
            'id': '1796994e-306a-4055-9f09-cc9a8d6c822d',
            'name': 'História do mundo',
            'progress': 0,
            'total_submodules': 2,
            'submodules': [
              {
                'name': 'Civilizações fundadoras',
                'has_finished': true,
                'is_available': true,
              },
              {
                'name': 'A Idade Média sem clichê',
                'has_finished': false,
                'is_available': false,
              },
            ],
          },
        ],
      });

      expect(data.id, '6ce95aac-c099-45f8-b3ad-2600ddf79356');
      expect(data.title, 'História');
      expect(data.modules, hasLength(1));

      final domain = data.toDomain();
      expect(domain.title, 'História');
      expect(domain.numberOfConcludedSubmodules, 1);
      expect(domain.modules.first.submodules.first.isAvailable, isTrue);
    });
  });
}
