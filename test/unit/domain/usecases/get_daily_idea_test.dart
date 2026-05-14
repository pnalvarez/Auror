import 'package:auror/layers/domain/usecases/get_daily_idea.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns idea aggregate', () async {
    final idea = await GetDailyIdea().call();
    expect(idea.totalTime, 10);
    expect(idea.completedCards, isNotEmpty);
    expect(idea.incompleteCards, isNotEmpty);
  }, timeout: const Timeout(Duration(seconds: 3)));
}
