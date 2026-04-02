import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'guided_routes_hub_ui.freezed.dart';

/// Presentation model for a guided route card, mapped from [GuidedRouteIntroDomain].
@freezed
sealed class GuidedRouteIntroUI with _$GuidedRouteIntroUI {
  const GuidedRouteIntroUI._();

  const factory GuidedRouteIntroUI({
    required String topic,
    required bool isPremiumMode,
    required String title,
    required String description,
  }) = _GuidedRouteIntroUI;

  factory GuidedRouteIntroUI.fromDomain(GuidedRouteIntroDomain domain) {
    return GuidedRouteIntroUI(
      topic: domain.topic,
      isPremiumMode: domain.isPremiumMode,
      title: domain.title,
      description: domain.description,
    );
  }
}
