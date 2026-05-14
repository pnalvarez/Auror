import 'package:auror/layers/domain/usecases/get_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/mocks.mocks.dart';

void main() {
  test('delegates to profile repository', () async {
    final repo = MockIProfileRepository();
    final sut = GetProfile(repo);
    final expected = kExpectedProfileDomain(kFixtureUser);
    when(repo.getProfile()).thenAnswer((_) async => expected);

    final result = await sut.call();

    expect(result.username, expected.username);
    verify(repo.getProfile()).called(1);
  });
}
