import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:auror/layers/domain/usecases/get_guided_route_intros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockIGuidedRouteRepository repository;
  late GetGuidedRouteIntros sut;

  setUp(() {
    repository = MockIGuidedRouteRepository();
    sut = GetGuidedRouteIntros(repository);
  });

  test('delegates to guided route repository', () async {
    when(repository.getGuidedRoutes()).thenAnswer(
      (_) async => const [
        GuidedRouteIntroDomain(
          topic: 'Produtividade',
          isPremiumMode: false,
          title: 'Foco profundo',
          description: 'Desc',
        ),
      ],
    );

    final result = await sut();

    expect(result, hasLength(1));
    expect(result.first.title, 'Foco profundo');
    verify(repository.getGuidedRoutes()).called(1);
  });
}
