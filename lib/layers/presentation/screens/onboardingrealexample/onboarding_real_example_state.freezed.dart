// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_real_example_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingRealExampleState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingRealExampleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingRealExampleState()';
}


}

/// @nodoc
class $OnboardingRealExampleStateCopyWith<$Res>  {
$OnboardingRealExampleStateCopyWith(OnboardingRealExampleState _, $Res Function(OnboardingRealExampleState) __);
}


/// Adds pattern-matching-related methods to [OnboardingRealExampleState].
extension OnboardingRealExampleStatePatterns on OnboardingRealExampleState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingRealExampleStateInitial value)?  initial,TResult Function( OnboardingRealExampleStateRecallCardRevealed value)?  recallCardRevealed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnboardingRealExampleStateInitial() when initial != null:
return initial(_that);case OnboardingRealExampleStateRecallCardRevealed() when recallCardRevealed != null:
return recallCardRevealed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingRealExampleStateInitial value)  initial,required TResult Function( OnboardingRealExampleStateRecallCardRevealed value)  recallCardRevealed,}){
final _that = this;
switch (_that) {
case OnboardingRealExampleStateInitial():
return initial(_that);case OnboardingRealExampleStateRecallCardRevealed():
return recallCardRevealed(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingRealExampleStateInitial value)?  initial,TResult? Function( OnboardingRealExampleStateRecallCardRevealed value)?  recallCardRevealed,}){
final _that = this;
switch (_that) {
case OnboardingRealExampleStateInitial() when initial != null:
return initial(_that);case OnboardingRealExampleStateRecallCardRevealed() when recallCardRevealed != null:
return recallCardRevealed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool hasActiveSession)?  recallCardRevealed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingRealExampleStateInitial() when initial != null:
return initial();case OnboardingRealExampleStateRecallCardRevealed() when recallCardRevealed != null:
return recallCardRevealed(_that.hasActiveSession);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool hasActiveSession)  recallCardRevealed,}) {final _that = this;
switch (_that) {
case OnboardingRealExampleStateInitial():
return initial();case OnboardingRealExampleStateRecallCardRevealed():
return recallCardRevealed(_that.hasActiveSession);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool hasActiveSession)?  recallCardRevealed,}) {final _that = this;
switch (_that) {
case OnboardingRealExampleStateInitial() when initial != null:
return initial();case OnboardingRealExampleStateRecallCardRevealed() when recallCardRevealed != null:
return recallCardRevealed(_that.hasActiveSession);case _:
  return null;

}
}

}

/// @nodoc


class OnboardingRealExampleStateInitial extends OnboardingRealExampleState {
   OnboardingRealExampleStateInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingRealExampleStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingRealExampleState.initial()';
}


}




/// @nodoc


class OnboardingRealExampleStateRecallCardRevealed extends OnboardingRealExampleState {
   OnboardingRealExampleStateRecallCardRevealed(this.hasActiveSession): super._();
  

 final  bool hasActiveSession;

/// Create a copy of OnboardingRealExampleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingRealExampleStateRecallCardRevealedCopyWith<OnboardingRealExampleStateRecallCardRevealed> get copyWith => _$OnboardingRealExampleStateRecallCardRevealedCopyWithImpl<OnboardingRealExampleStateRecallCardRevealed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingRealExampleStateRecallCardRevealed&&(identical(other.hasActiveSession, hasActiveSession) || other.hasActiveSession == hasActiveSession));
}


@override
int get hashCode => Object.hash(runtimeType,hasActiveSession);

@override
String toString() {
  return 'OnboardingRealExampleState.recallCardRevealed(hasActiveSession: $hasActiveSession)';
}


}

/// @nodoc
abstract mixin class $OnboardingRealExampleStateRecallCardRevealedCopyWith<$Res> implements $OnboardingRealExampleStateCopyWith<$Res> {
  factory $OnboardingRealExampleStateRecallCardRevealedCopyWith(OnboardingRealExampleStateRecallCardRevealed value, $Res Function(OnboardingRealExampleStateRecallCardRevealed) _then) = _$OnboardingRealExampleStateRecallCardRevealedCopyWithImpl;
@useResult
$Res call({
 bool hasActiveSession
});




}
/// @nodoc
class _$OnboardingRealExampleStateRecallCardRevealedCopyWithImpl<$Res>
    implements $OnboardingRealExampleStateRecallCardRevealedCopyWith<$Res> {
  _$OnboardingRealExampleStateRecallCardRevealedCopyWithImpl(this._self, this._then);

  final OnboardingRealExampleStateRecallCardRevealed _self;
  final $Res Function(OnboardingRealExampleStateRecallCardRevealed) _then;

/// Create a copy of OnboardingRealExampleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hasActiveSession = null,}) {
  return _then(OnboardingRealExampleStateRecallCardRevealed(
null == hasActiveSession ? _self.hasActiveSession : hasActiveSession // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
