import 'package:auror/layers/data/models/subscription_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubscriptionCheckpointData', () {
    test('fromJson and toJson', () {
      final cp = SubscriptionCheckpointData.fromJson(<String, dynamic>{
        'id': 1,
        'text': 'Benefit',
        'subscription_id': 'sub-1',
      });
      expect(cp.text, 'Benefit');
      expect(cp.toJson()['subscription_id'], 'sub-1');
    });
  });

  group('SubscriptionData', () {
    test('parses modern view fields', () {
      final data = SubscriptionData.fromJson(<String, dynamic>{
        'id': 'plan-a',
        'name': 'Pro',
        'description': 'All features',
        'is_paid': true,
        'is_current': false,
        'price_cents': 1990,
        'duration_days': 365,
        'checkpoint_texts': ['A', 'B'],
      });

      expect(data.id, 'plan-a');
      expect(data.subscriptionName, 'Pro');
      expect(data.price, 1990);
      expect(data.period, 365);
      expect(data.benefitLines, ['A', 'B']);
    });

    test('parses legacy fields and numeric id', () {
      final data = SubscriptionData.fromJson(<String, dynamic>{
        'id': 42,
        'subscription_name': 'Legacy',
        'description': 'd',
        'price': '990',
        'period': 30,
        'price_cents': 0,
        'checkpoints': [
          {'id': 1, 'text': 'Legacy benefit', 'subscription_id': '42'},
        ],
      });

      expect(data.id, '42');
      expect(data.subscriptionName, 'Legacy');
      expect(data.isPaid, isFalse);
      expect(data.benefitLines, ['Legacy benefit']);
    });

    test('isPaid inferred from price_cents when is_paid missing', () {
      final data = SubscriptionData.fromJson(<String, dynamic>{
        'id': 'x',
        'subscription_name': 'Paid',
        'description': '',
        'price_cents': 500,
        'duration_days': 30,
      });
      expect(data.isPaid, isTrue);
    });

    test('toDomain maps benefit lines', () {
      final data = SubscriptionData.fromJson(<String, dynamic>{
        'id': '1',
        'name': 'Basic',
        'description': 'd',
        'is_paid': false,
        'is_current': true,
        'price_cents': 0,
        'duration_days': 7,
        'checkpoint_texts': ['Free perk'],
      });

      final domain = data.toDomain();
      expect(domain.benefits, ['Free perk']);
      expect(domain.isCurrent, isTrue);
    });

    test('parses numeric id and legacy price/period', () {
      final data = SubscriptionData.fromJson(<String, dynamic>{
        'id': 7,
        'subscription_name': 'X',
        'description': 'd',
        'price': 1500,
        'period': 14,
      });
      expect(data.id, '7');
      expect(data.price, 1500);
      expect(data.period, 14);
    });

    test('read helpers handle null and legacy keys', () {
      final data = SubscriptionData.fromJson(<String, dynamic>{
        'id': null,
        'subscription_name': '',
        'description': null,
        'is_current': null,
        'period': 14,
      });
      expect(data.id, '');
      expect(data.description, '');
      expect(data.isCurrent, isFalse);
      expect(data.period, 14);
    });
  });
}
