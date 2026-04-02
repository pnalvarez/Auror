import 'package:auror/layers/domain/usecases/get_profile.dart';
import 'package:auror/layers/presentation/screens/profile/profile_event.dart';
import 'package:auror/layers/presentation/screens/profile/profile_state.dart';
import 'package:auror/layers/presentation/screens/profile/profile_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Bloc<ProfileEvent, ProfileState> {
  ProfileViewModel(this._getProfile) : super(const ProfileState()) {
    on<ProfileLoadRequested>(_onLoadRequested);
  }

  final IGetProfile _getProfile;

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final domain = await _getProfile();
      emit(
        state.copyWith(
          isLoading: false,
          profile: ProfileUI.fromDomain(domain),
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          profile: null,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
