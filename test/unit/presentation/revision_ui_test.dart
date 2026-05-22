import 'package:auror/layers/presentation/screens/home/revision_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stores title and time', () {
    const ui = RevisionUi(title: 'Revision A', time: '5 min');
    expect(ui.title, 'Revision A');
    expect(ui.time, '5 min');
  });
}
