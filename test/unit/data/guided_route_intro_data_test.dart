import 'package:auror/layers/data/models/guided_route_intro_data.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';

void main() {
  test('fromJson parses embedded category', () {
    final data = GuidedRouteIntroData.fromJson({
      'id': 'route-1',
      'name': 'Feedback construtivo',
      'category_id': 'cat-1',
      'description': 'Como dar feedback.',
      'is_premium': true,
      'categories': {'name': 'Comunicação'},
    });

    expect(data.name, 'Feedback construtivo');
    expect(data.categories?.name, 'Comunicação');
    expect(data.isPremium, isTrue);
  });

  test('toDomain maps name and category to title and topic', () {
    final domain = kFixtureGuidedRouteIntroData.toDomain();

    expect(domain.title, 'Foco profundo');
    expect(domain.topic, 'Produtividade');
    expect(domain.isPremiumMode, isTrue);
  });
}
