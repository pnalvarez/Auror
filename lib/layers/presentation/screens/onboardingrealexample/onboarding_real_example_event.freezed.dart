// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_real_example_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingRealExampleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingRealExampleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingRealExampleEvent()';
}


}

/// @nodoc
class $OnboardingRealExampleEventCopyWith<$Res>  {
$OnboardingRealExampleEventCopyWith(OnboardingRealExampleEvent _, $Res Function(OnboardingRealExampleEvent) __);
}


/// Adds pattern-matching-related methods to [OnboardingRealExampleEvent].
extension OnboardingRealExampleEventPatterns on OnboardingRealExampleEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingRealExampleStarted value)?  started,TResult Function( OnboardingRealExampleRecallCardRevealed value)?  recallCardRevealed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnboardingRealExampleStarted() when started != null:
return started(_that);case OnboardingRealExampleRecallCardRevealed() when recallCardRevealed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingRealExampleStarted value)  started,required TResult Function( OnboardingRealExampleRecallCardRevealed value)  recallCardRevealed,}){
final _that = this;
switch (_that) {
case OnboardingRealExampleStarted():
return started(_that);case OnboardingRealExampleRecallCardRevealed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingRealExampleStarted value)?  started,TResult? Function( OnboardingRealExampleRecallCardRevealed value)?  recallCardRevealed,}){
final _that = this;
switch (_that) {
case OnboardingRealExampleStarted() when started != null:
return started(_that);case OnboardingRealExampleRecallCardRevealed() when recallCardRevealed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  recallCardRevealed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingRealExampleStarted() when started != null:
return started();case OnboardingRealExampleRecallCardRevealed() when recallCardRevealed != null:
return recallCardRevealed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  recallCardRevealed,}) {final _that = this;
switch (_that) {
case OnboardingRealExampleStarted():
return started();case OnboardingRealExampleRecallCardRevealed():
return recallCardRevealed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  recallCardRevealed,}) {final _that = this;
switch (_that) {
case OnboardingRealExampleStarted() when started != null:
return started();case OnboardingRealExampleRecallCardRevealed() when recallCardRevealed != null:
return recallCardRevealed();case _:
  return null;

}
}

}

/// @nodoc


class OnboardingRealExampleStarted implements OnboardingRealExampleEvent {
  const OnboardingRealExampleStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingRealExampleStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingRealExampleEvent.started()';
}


}




/// @nodoc


class OnboardingRealExampleRecallCardRevealed implements OnboardingRealExampleEvent {
  const OnboardingRealExampleRecallCardRevealed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingRealExampleRecallCardRevealed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingRealExampleEvent.recallCardRevealed()';
}


}




// dart format on
