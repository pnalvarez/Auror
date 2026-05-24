import 'package:auror/layers/domain/usecases/get_current_subscription.dart';
import 'package:auror/layers/domain/usecases/get_guided_route_intros.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GuidedRoutesHubViewModel
    extends Bloc<GuidedRoutesHubEvent, GuidedRoutesHubState> {
  GuidedRoutesHubViewModel(this._getGuidedRouteIntros, this._getCurrentSubscription)
    : super(const GuidedRoutesHubState()) {
    on<GuidedRoutesHubLoadRequested>(_onLoadRequested);
  }

  final IGetGuidedRouteIntros _getGuidedRouteIntros;
  final IGetCurrentSubscription _getCurrentSubscription;

  Future<void> _onLoadRequested(
    GuidedRoutesHubLoadRequested event,
    Emitter<GuidedRoutesHubState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final domainList = await _getGuidedRouteIntros();
      final subscription = await _getCurrentSubscription();
      final routes = domainList.map(GuidedRouteIntroUI.fromDomain).toList();
      emit(
        state.copyWith(
          isLoading: false,
          routes: routes,
          errorMessage: null,
          isUserPremium: subscription.isPaid,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          routes: [],
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
