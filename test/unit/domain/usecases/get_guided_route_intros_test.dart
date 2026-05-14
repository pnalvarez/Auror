import 'package:auror/layers/domain/usecases/get_guided_route_intros.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns static intros', () async {
    final intros = await GetGuidedRouteIntros().call();
    expect(intros, hasLength(3));
    expect(intros.first.topic, 'Desenvolvimento Pessoal');
  });
}
