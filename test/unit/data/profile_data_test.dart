import 'package:auror/layers/data/models/profile_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromJson and toJson round-trip', () {
    final json = <String, dynamic>{
      'user_id': 'uid-1',
      'avatar_url': 'https://cdn.example/a.png',
      'followed_days': 5,
      'learned_cards': 10,
      'revisions_done': 2,
      'updated_at': '2024-06-01T12:00:00.000Z',
      'is_subscribed': true,
    };

    final data = ProfileData.fromJson(json);
    expect(data.userId, 'uid-1');
    expect(data.avatarUrl, 'https://cdn.example/a.png');
    expect(data.isSubscribed, isTrue);
    expect(data.toJson()['user_id'], 'uid-1');
  });

  test('isSubscribed defaults to false when key missing', () {
    final data = ProfileData.fromJson(<String, dynamic>{
      'user_id': 'u',
      'followed_days': 0,
      'learned_cards': 0,
      'revisions_done': 0,
    });
    expect(data.isSubscribed, isFalse);
  });
}
