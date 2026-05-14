import 'package:auror/layers/domain/usecases/get_card_revision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns revision for card id', () async {
    final rev = await GetCardRevision().call(cardId: 'cid-9');
    expect(rev.cardId, 'cid-9');
    expect(rev.minutes, 5);
  }, timeout: const Timeout(Duration(seconds: 3)));
}
