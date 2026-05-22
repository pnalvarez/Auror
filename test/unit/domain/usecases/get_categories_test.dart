import 'package:auror/layers/domain/usecases/get_categories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns static list', () async {
    final cats = await GetCategories().call();
    expect(cats, hasLength(3));
    expect(cats.first.id, 'personal_development');
  });
}
