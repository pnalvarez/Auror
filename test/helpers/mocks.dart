// Run `dart run build_runner build --delete-conflicting-outputs` after changing
// @GenerateMocks below.
import 'package:auror/layers/data/api/api_client.dart';
import 'package:auror/layers/data/client/auth_client.dart';
import 'package:auror/layers/data/datasource/api_data_source.dart';
import 'package:auror/layers/data/datasource/auth_data_source.dart';
import 'package:auror/layers/domain/repository/auth_repository.dart';
import 'package:auror/layers/domain/repository/profile_repository.dart';
import 'package:auror/layers/domain/repository/subscription_repository.dart';
import 'package:auror/layers/domain/usecases/cancel_subscription.dart';
import 'package:auror/layers/domain/usecases/get_card_revision.dart';
import 'package:auror/layers/domain/usecases/get_categories.dart';
import 'package:auror/layers/domain/usecases/get_current_subscription.dart';
import 'package:auror/layers/domain/usecases/get_daily_idea.dart';
import 'package:auror/layers/domain/usecases/get_guided_route_intros.dart';
import 'package:auror/layers/domain/usecases/get_membership.dart';
import 'package:auror/layers/domain/usecases/get_next_card.dart';
import 'package:auror/layers/domain/usecases/get_profile.dart';
import 'package:auror/layers/domain/usecases/get_revisions.dart';
import 'package:auror/layers/domain/usecases/get_subscriptions.dart';
import 'package:auror/layers/domain/usecases/get_user.dart';
import 'package:auror/layers/domain/usecases/save_recall_card.dart';
import 'package:auror/layers/domain/usecases/select_subscription.dart';
import 'package:auror/layers/domain/usecases/send_answer.dart';
import 'package:auror/layers/domain/usecases/sign_in.dart';
import 'package:auror/layers/domain/usecases/has_active_session.dart';
import 'package:auror/layers/domain/usecases/sign_out.dart';
import 'package:auror/layers/domain/usecases/sign_up.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase/supabase.dart' show GoTrueClient;
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateMocks([
  GoTrueClient,
  SupabaseClient,
  IApiClient,
  IAuthService,
  IAuthDataSource,
  IApiDataSource,
  IAuthRepository,
  IProfileRepository,
  ISubscriptionRepository,
  IGetUser,
  IGetRevisions,
  IGetDailyIdea,
  ISignIn,
  ISignUp,
  ISignOut,
  IHasActiveSession,
  IGetProfile,
  IGetCurrentSubscription,
  IGetSubscriptions,
  ISelectSubscription,
  ICancelSubscription,
  IGetCategories,
  IGetNextCard,
  IGetGuidedRouteIntros,
  IGetMembership,
  ISaveRecallCard,
  ISendAnswer,
  IGetCardRevision,
  User,
])
void main() {}
