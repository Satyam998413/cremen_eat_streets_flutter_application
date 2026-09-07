// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reviews_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReviewsState()';
}


}

/// @nodoc
class $ReviewsStateCopyWith<$Res>  {
$ReviewsStateCopyWith(ReviewsState _, $Res Function(ReviewsState) __);
}


/// Adds pattern-matching-related methods to [ReviewsState].
extension ReviewsStatePatterns on ReviewsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReviewsLoading value)?  loading,TResult Function( ReviewsLoaded value)?  loaded,TResult Function( ReviewsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReviewsLoading() when loading != null:
return loading(_that);case ReviewsLoaded() when loaded != null:
return loaded(_that);case ReviewsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReviewsLoading value)  loading,required TResult Function( ReviewsLoaded value)  loaded,required TResult Function( ReviewsFailure value)  failure,}){
final _that = this;
switch (_that) {
case ReviewsLoading():
return loading(_that);case ReviewsLoaded():
return loaded(_that);case ReviewsFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReviewsLoading value)?  loading,TResult? Function( ReviewsLoaded value)?  loaded,TResult? Function( ReviewsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ReviewsLoading() when loading != null:
return loading(_that);case ReviewsLoaded() when loaded != null:
return loaded(_that);case ReviewsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<Review> reviews,  String? eligibleOrderId,  bool isSubmitting,  bool submitSucceeded,  String? submitError)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReviewsLoading() when loading != null:
return loading();case ReviewsLoaded() when loaded != null:
return loaded(_that.reviews,_that.eligibleOrderId,_that.isSubmitting,_that.submitSucceeded,_that.submitError);case ReviewsFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<Review> reviews,  String? eligibleOrderId,  bool isSubmitting,  bool submitSucceeded,  String? submitError)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ReviewsLoading():
return loading();case ReviewsLoaded():
return loaded(_that.reviews,_that.eligibleOrderId,_that.isSubmitting,_that.submitSucceeded,_that.submitError);case ReviewsFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<Review> reviews,  String? eligibleOrderId,  bool isSubmitting,  bool submitSucceeded,  String? submitError)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ReviewsLoading() when loading != null:
return loading();case ReviewsLoaded() when loaded != null:
return loaded(_that.reviews,_that.eligibleOrderId,_that.isSubmitting,_that.submitSucceeded,_that.submitError);case ReviewsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ReviewsLoading implements ReviewsState {
  const ReviewsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReviewsState.loading()';
}


}




/// @nodoc


class ReviewsLoaded implements ReviewsState {
  const ReviewsLoaded({required final  List<Review> reviews, this.eligibleOrderId, this.isSubmitting = false, this.submitSucceeded = false, this.submitError}): _reviews = reviews;
  

 final  List<Review> _reviews;
 List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

 final  String? eligibleOrderId;
@JsonKey() final  bool isSubmitting;
@JsonKey() final  bool submitSucceeded;
 final  String? submitError;

/// Create a copy of ReviewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewsLoadedCopyWith<ReviewsLoaded> get copyWith => _$ReviewsLoadedCopyWithImpl<ReviewsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsLoaded&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.eligibleOrderId, eligibleOrderId) || other.eligibleOrderId == eligibleOrderId)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.submitSucceeded, submitSucceeded) || other.submitSucceeded == submitSucceeded)&&(identical(other.submitError, submitError) || other.submitError == submitError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reviews),eligibleOrderId,isSubmitting,submitSucceeded,submitError);

@override
String toString() {
  return 'ReviewsState.loaded(reviews: $reviews, eligibleOrderId: $eligibleOrderId, isSubmitting: $isSubmitting, submitSucceeded: $submitSucceeded, submitError: $submitError)';
}


}

/// @nodoc
abstract mixin class $ReviewsLoadedCopyWith<$Res> implements $ReviewsStateCopyWith<$Res> {
  factory $ReviewsLoadedCopyWith(ReviewsLoaded value, $Res Function(ReviewsLoaded) _then) = _$ReviewsLoadedCopyWithImpl;
@useResult
$Res call({
 List<Review> reviews, String? eligibleOrderId, bool isSubmitting, bool submitSucceeded, String? submitError
});




}
/// @nodoc
class _$ReviewsLoadedCopyWithImpl<$Res>
    implements $ReviewsLoadedCopyWith<$Res> {
  _$ReviewsLoadedCopyWithImpl(this._self, this._then);

  final ReviewsLoaded _self;
  final $Res Function(ReviewsLoaded) _then;

/// Create a copy of ReviewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reviews = null,Object? eligibleOrderId = freezed,Object? isSubmitting = null,Object? submitSucceeded = null,Object? submitError = freezed,}) {
  return _then(ReviewsLoaded(
reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,eligibleOrderId: freezed == eligibleOrderId ? _self.eligibleOrderId : eligibleOrderId // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,submitSucceeded: null == submitSucceeded ? _self.submitSucceeded : submitSucceeded // ignore: cast_nullable_to_non_nullable
as bool,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ReviewsFailure implements ReviewsState {
  const ReviewsFailure(this.message);
  

 final  String message;

/// Create a copy of ReviewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewsFailureCopyWith<ReviewsFailure> get copyWith => _$ReviewsFailureCopyWithImpl<ReviewsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ReviewsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ReviewsFailureCopyWith<$Res> implements $ReviewsStateCopyWith<$Res> {
  factory $ReviewsFailureCopyWith(ReviewsFailure value, $Res Function(ReviewsFailure) _then) = _$ReviewsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ReviewsFailureCopyWithImpl<$Res>
    implements $ReviewsFailureCopyWith<$Res> {
  _$ReviewsFailureCopyWithImpl(this._self, this._then);

  final ReviewsFailure _self;
  final $Res Function(ReviewsFailure) _then;

/// Create a copy of ReviewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ReviewsFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
