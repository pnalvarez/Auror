import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubscriptionCheckpointData {
  const SubscriptionCheckpointData({
    required this.id,
    required this.text,
    required this.subscriptionId,
  });

  final int id;
  final String text;
  final String subscriptionId;

  factory SubscriptionCheckpointData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionCheckpointDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionCheckpointDataToJson(this);
}

/// Linha da view REST (ex. `full_subscriptions`) ou formato legado com
/// `subscription_name` / `is_paid` / `price` em texto.
@JsonSerializable(fieldRename: FieldRename.snake)
class SubscriptionData {
  const SubscriptionData({
    required this.id,
    required this.subscriptionName,
    required this.description,
    required this.isPaid,
    required this.isCurrent,
    required this.price,
    required this.period,
    this.checkpointTexts = const [],
    this.checkpoints = const [],
  });

  @JsonKey(readValue: _readId)
  final String id;

  @JsonKey(readValue: _readSubscriptionName)
  final String subscriptionName;

  @JsonKey(readValue: _readDescription)
  final String description;

  @JsonKey(readValue: _readIsPaid)
  final bool isPaid;

  @JsonKey(readValue: _readIsCurrent)
  final bool isCurrent;

  @JsonKey(readValue: _readPrice)
  final int price;

  @JsonKey(readValue: _readPeriod)
  final int period;

  @JsonKey(name: 'checkpoint_texts')
  final List<String> checkpointTexts;

  @JsonKey(name: 'subscription_checkpoints', readValue: _readCheckpointsValue)
  final List<SubscriptionCheckpointData> checkpoints;

  /// Benefícios para UI: view com array; senão textos das linhas embutidas.
  List<String> get benefitLines => checkpointTexts.isNotEmpty
      ? checkpointTexts
      : checkpoints.map((c) => c.text).toList();

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionDataToJson(this);

  static Object? _readId(Map json, String key) {
    final v = json['id'];
    if (v is String) return v;
    if (v is num) return v.toString();
    if (v != null) return v.toString();
    return '';
  }

  static Object? _readSubscriptionName(Map json, String key) =>
      json['name']?.toString() ?? json['subscription_name']?.toString() ?? '';

  static Object? _readDescription(Map json, String key) =>
      json['description'] ?? '';

  static Object? _readIsPaid(Map json, String key) {
    final paid = json['is_paid'];
    if (paid is bool) return paid;
    final cents = json['price_cents'];
    if (cents is num) return cents.toInt() > 0;
    return false;
  }

  static Object? _readIsCurrent(Map json, String key) =>
      json['is_current'] as bool? ?? false;

  /// Centavos (ex. coluna `price_cents` / `int4`). Alinha com [SubscriptionDomain.price].
  static Object? _readPrice(Map json, String key) {
    final cents = json['price_cents'];
    if (cents is num) return cents.toInt();
    final legacy = json['price'];
    if (legacy is num) return legacy.toInt();
    return 0;
  }

  /// Dias (ex. `duration_days` / `int4`). Alinha com [SubscriptionDomain.period].
  static Object? _readPeriod(Map json, String key) {
    final days = json['duration_days'];
    if (days is num) return days.toInt();
    final legacy = json['period'];
    if (legacy is num) return legacy.toInt();
    return 0;
  }

  static Object? _readCheckpointsValue(Map json, String key) =>
      json[key] ?? json['checkpoints'];

  SubscriptionDomain toDomain() => SubscriptionDomain(
    id: id,
    subscriptionName: subscriptionName,
    description: description,
    isPaid: isPaid,
    isCurrent: isCurrent,
    price: price,
    period: period,
    benefits: benefitLines,
  );
}
