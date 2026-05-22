import 'package:auror/layers/domain/usecases/get_revisions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns mock section', () async {
    final section = await GetRevisions().call();
    expect(section.revisions, isNotEmpty);
    expect(section.tomorrowCount, 1);
  }, timeout: const Timeout(Duration(seconds: 2)));
}
