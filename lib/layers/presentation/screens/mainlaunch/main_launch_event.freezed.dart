// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_launch_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainLaunchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainLaunchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainLaunchEvent()';
}


}

/// @nodoc
class $MainLaunchEventCopyWith<$Res>  {
$MainLaunchEventCopyWith(MainLaunchEvent _, $Res Function(MainLaunchEvent) __);
}


/// Adds pattern-matching-related methods to [MainLaunchEvent].
extension MainLaunchEventPatterns on MainLaunchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MainLaunchStarted value)?  started,TResult Function( MainLaunchEnterAppTapped value)?  enterAppTapped,TResult Function( MainLaunchHowItWorksTapped value)?  howItWorksTapped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MainLaunchStarted() when started != null:
return started(_that);case MainLaunchEnterAppTapped() when enterAppTapped != null:
return enterAppTapped(_that);case MainLaunchHowItWorksTapped() when howItWorksTapped != null:
return howItWorksTapped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MainLaunchStarted value)  started,required TResult Function( MainLaunchEnterAppTapped value)  enterAppTapped,required TResult Function( MainLaunchHowItWorksTapped value)  howItWorksTapped,}){
final _that = this;
switch (_that) {
case MainLaunchStarted():
return started(_that);case MainLaunchEnterAppTapped():
return enterAppTapped(_that);case MainLaunchHowItWorksTapped():
return howItWorksTapped(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MainLaunchStarted value)?  started,TResult? Function( MainLaunchEnterAppTapped value)?  enterAppTapped,TResult? Function( MainLaunchHowItWorksTapped value)?  howItWorksTapped,}){
final _that = this;
switch (_that) {
case MainLaunchStarted() when started != null:
return started(_that);case MainLaunchEnterAppTapped() when enterAppTapped != null:
return enterAppTapped(_that);case MainLaunchHowItWorksTapped() when howItWorksTapped != null:
return howItWorksTapped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  enterAppTapped,TResult Function()?  howItWorksTapped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MainLaunchStarted() when started != null:
return started();case MainLaunchEnterAppTapped() when enterAppTapped != null:
return enterAppTapped();case MainLaunchHowItWorksTapped() when howItWorksTapped != null:
return howItWorksTapped();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  enterAppTapped,required TResult Function()  howItWorksTapped,}) {final _that = this;
switch (_that) {
case MainLaunchStarted():
return started();case MainLaunchEnterAppTapped():
return enterAppTapped();case MainLaunchHowItWorksTapped():
return howItWorksTapped();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  enterAppTapped,TResult? Function()?  howItWorksTapped,}) {final _that = this;
switch (_that) {
case MainLaunchStarted() when started != null:
return started();case MainLaunchEnterAppTapped() when enterAppTapped != null:
return enterAppTapped();case MainLaunchHowItWorksTapped() when howItWorksTapped != null:
return howItWorksTapped();case _:
  return null;

}
}

}

/// @nodoc


class MainLaunchStarted implements MainLaunchEvent {
  const MainLaunchStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainLaunchStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainLaunchEvent.started()';
}


}




/// @nodoc


class MainLaunchEnterAppTapped implements MainLaunchEvent {
  const MainLaunchEnterAppTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainLaunchEnterAppTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainLaunchEvent.enterAppTapped()';
}


}




/// @nodoc


class MainLaunchHowItWorksTapped implements MainLaunchEvent {
  const MainLaunchHowItWorksTapped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainLaunchHowItWorksTapped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainLaunchEvent.howItWorksTapped()';
}


}




// dart format on
