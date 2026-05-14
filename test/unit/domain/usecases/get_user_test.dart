import 'package:auror/layers/domain/usecases/get_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns stub learner', () async {
    final user = await GetUser().call();
    expect(user.name, 'Auror Learner');
    expect(user.username, 'auror_learner');
  });
}
