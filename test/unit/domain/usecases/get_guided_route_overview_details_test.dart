import 'package:auror/layers/domain/usecases/get_guided_route_overview_details.dart';
import 'package:auror/layers/domain/usecases/guided_route_overview_mock_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns mocked guided route overview domain', () async {
    final useCase = GetGuidedRouteOverviewDetails();

    final result = await useCase();

    expect(result, kMockGuidedRouteOverviewDomain);
  });
}
