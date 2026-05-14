import 'package:auror/layers/domain/usecases/get_membership.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns basic tier', () async {
    final m = await GetMembership().call();
    expect(m.category, 'Basic');
    expect(m.isSubscribed, isFalse);
  }, timeout: const Timeout(Duration(seconds: 3)));
}
