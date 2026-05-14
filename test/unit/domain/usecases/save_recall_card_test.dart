import 'package:auror/layers/domain/usecases/save_recall_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('completes', () async {
    await expectLater(SaveRecallCard().call(cardId: 'x'), completes);
  });
}
