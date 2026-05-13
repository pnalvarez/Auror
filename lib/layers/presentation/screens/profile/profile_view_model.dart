import 'package:auror/layers/domain/usecases/get_current_subscription.dart';
import 'package:auror/layers/domain/usecases/get_profile.dart';
import 'package:auror/layers/domain/usecases/sign_out.dart';
import 'package:auror/layers/presentation/screens/login/login_auth_error_mapper.dart';
import 'package:auror/layers/presentation/screens/profile/profile_event.dart';
import 'package:auror/layers/presentation/screens/profile/profile_state.dart';
import 'package:auror/layers/presentation/screens/profile/profile_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Bloc<ProfileEvent, ProfileState> {
  ProfileViewModel(
    this._getProfile,
    this._signOut,
    this._getCurrentSubscription,
  ) : super(const ProfileState()) {
    // Single handler so every [ProfileEvent] variant is always routed (Bloc 9
    // matches handlers with `event is E`; one base registration covers all).
    on<ProfileEvent>(_onEvent);
  }

  final IGetProfile _getProfile;
  final ISignOut _signOut;
  final IGetCurrentSubscription _getCurrentSubscription;
  bool _isLoadingProfile = false;

  Future<void> _onEvent(ProfileEvent event, Emitter<ProfileState> emit) async {
    switch (event) {
      case ProfileLoadRequested():
        await _onLoadRequested(event, emit);
      case ProfileLogoutTapped():
        await _onLogoutTapped(event, emit);
      case ProfileMainLaunchNavigationConsumed():
        _onMainLaunchNavigationConsumed(event, emit);
    }
  }

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (_isLoadingProfile) return;
    _isLoadingProfile = true;
    emit(state.copyWith(isLoadingData: true, errorMessage: null));
    try {
      final profileDomain = await _getProfile();
      final subscriptionDomain = await _getCurrentSubscription();
      emit(
        state.copyWith(
          isLoadingData: false,
          profile: ProfileUI.fromDomain(profileDomain, subscriptionDomain),
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingData: false,
          profile: state.profile,
          errorMessage: e.toString(),
        ),
      );
    } finally {
      _isLoadingProfile = false;
    }
  }

  Future<void> _onLogoutTapped(
    ProfileLogoutTapped event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(pendingLogoutNavigation: true, errorMessage: null));
    try {
      await _signOut();
      emit(state.copyWith(pendingMainLaunchNavigation: true));
    } catch (e) {
      emit(state.copyWith(errorMessage: mapSignOutAuthErrorToPortuguese(e)));
    } finally {
      emit(state.copyWith(pendingLogoutNavigation: false));
    }
  }

  void _onMainLaunchNavigationConsumed(
    ProfileMainLaunchNavigationConsumed event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(pendingMainLaunchNavigation: false));
  }
}
