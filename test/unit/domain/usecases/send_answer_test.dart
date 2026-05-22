import 'package:auror/layers/domain/usecases/send_answer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('completes', () async {
    await expectLater(
      SendAnswer().call(answer: 'a', revisionId: 'r'),
      completes,
    );
  });
}
