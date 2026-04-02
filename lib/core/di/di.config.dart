// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auror/layers/domain/usecases/get_guided_route_intros.dart'
    as _i596;
import 'package:auror/layers/domain/usecases/get_profile.dart' as _i757;
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_view_model.dart'
    as _i326;
import 'package:auror/layers/presentation/screens/profile/profile_view_model.dart'
    as _i593;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i596.IGetGuidedRouteIntros>(() => _i596.GetGuidedRouteIntros());
    gh.factory<_i326.GuidedRoutesHubViewModel>(
      () => _i326.GuidedRoutesHubViewModel(gh<_i596.IGetGuidedRouteIntros>()),
    );
    gh.factory<_i757.IGetProfile>(() => _i757.GetProfile());
    gh.factory<_i593.ProfileViewModel>(
      () => _i593.ProfileViewModel(gh<_i757.IGetProfile>()),
    );
    return this;
  }
}
