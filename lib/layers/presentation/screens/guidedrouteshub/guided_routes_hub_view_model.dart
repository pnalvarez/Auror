import 'package:auror/layers/domain/usecases/get_guided_route_intros.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GuidedRoutesHubViewModel
    extends Bloc<GuidedRoutesHubEvent, GuidedRoutesHubState> {
  GuidedRoutesHubViewModel(this._getGuidedRouteIntros)
    : super(const GuidedRoutesHubState()) {
    on<GuidedRoutesHubLoadRequested>(_onLoadRequested);
    on<GuidedRoutesHubRouteSelected>(_onRouteSelected);
  }

  final IGetGuidedRouteIntros _getGuidedRouteIntros;

  Future<void> _onLoadRequested(
    GuidedRoutesHubLoadRequested event,
    Emitter<GuidedRoutesHubState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final domainList = await _getGuidedRouteIntros();
      final routes = domainList.map(GuidedRouteIntroUI.fromDomain).toList();
      emit(
        state.copyWith(
          isLoading: false,
          routes: routes,
          selectedIndex: null,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          routes: [],
          selectedIndex: null,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onRouteSelected(
    GuidedRoutesHubRouteSelected event,
    Emitter<GuidedRoutesHubState> emit,
  ) {
    if (event.index < 0 || event.index >= state.routes.length) {
      return;
    }
    emit(state.copyWith(selectedIndex: event.index));
  }
}
