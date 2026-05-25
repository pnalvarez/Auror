import 'package:auror/layers/domain/usecases/get_guided_route_overview_details.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GuidedRouteOverviewViewModel extends Bloc<GuidedRouteOverviewEvent, GuidedRouteOverviewState> {
  GuidedRouteOverviewViewModel(
    @factoryParam this._guidedRouteId,
    this._getGuidedRouteOverviewDetails,
  ) : super(const GuidedRouteOverviewState()) {
    on<GuidedRouteOverviewLoadRequested>(_onLoadRequested);
  }

  final String _guidedRouteId;
  final IGetGuidedRouteOverviewDetails _getGuidedRouteOverviewDetails;

  Future<void> _onLoadRequested(
    GuidedRouteOverviewLoadRequested event,
    Emitter<GuidedRouteOverviewState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final domain = await _getGuidedRouteOverviewDetails(
        guidedRouteId: _guidedRouteId,
      );
      emit(
        state.copyWith(
          isLoading: false,
          overview: GuidedRouteOverviewUI.fromDomain(domain),
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          overview: null,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
