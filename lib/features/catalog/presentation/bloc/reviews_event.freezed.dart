// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reviews_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReviewsEvent()';
}


}

/// @nodoc
class $ReviewsEventCopyWith<$Res>  {
$ReviewsEventCopyWith(ReviewsEvent _, $Res Function(ReviewsEvent) __);
}


/// Adds pattern-matching-related methods to [ReviewsEvent].
extension ReviewsEventPatterns on ReviewsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReviewsLoadRequested value)?  loadRequested,TResult Function( ReviewsSubmitRequested value)?  submitRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReviewsLoadRequested() when loadRequested != null:
return loadRequested(_that);case ReviewsSubmitRequested() when submitRequested != null:
return submitRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReviewsLoadRequested value)  loadRequested,required TResult Function( ReviewsSubmitRequested value)  submitRequested,}){
final _that = this;
switch (_that) {
case ReviewsLoadRequested():
return loadRequested(_that);case ReviewsSubmitRequested():
return submitRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReviewsLoadRequested value)?  loadRequested,TResult? Function( ReviewsSubmitRequested value)?  submitRequested,}){
final _that = this;
switch (_that) {
case ReviewsLoadRequested() when loadRequested != null:
return loadRequested(_that);case ReviewsSubmitRequested() when submitRequested != null:
return submitRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String productId)?  loadRequested,TResult Function( String reviewerName,  int rating,  String? comment)?  submitRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReviewsLoadRequested() when loadRequested != null:
return loadRequested(_that.productId);case ReviewsSubmitRequested() when submitRequested != null:
return submitRequested(_that.reviewerName,_that.rating,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String productId)  loadRequested,required TResult Function( String reviewerName,  int rating,  String? comment)  submitRequested,}) {final _that = this;
switch (_that) {
case ReviewsLoadRequested():
return loadRequested(_that.productId);case ReviewsSubmitRequested():
return submitRequested(_that.reviewerName,_that.rating,_that.comment);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String productId)?  loadRequested,TResult? Function( String reviewerName,  int rating,  String? comment)?  submitRequested,}) {final _that = this;
switch (_that) {
case ReviewsLoadRequested() when loadRequested != null:
return loadRequested(_that.productId);case ReviewsSubmitRequested() when submitRequested != null:
return submitRequested(_that.reviewerName,_that.rating,_that.comment);case _:
  return null;

}
}

}

/// @nodoc


class ReviewsLoadRequested implements ReviewsEvent {
  const ReviewsLoadRequested(this.productId);
  

 final  String productId;

/// Create a copy of ReviewsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewsLoadRequestedCopyWith<ReviewsLoadRequested> get copyWith => _$ReviewsLoadRequestedCopyWithImpl<ReviewsLoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsLoadRequested&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'ReviewsEvent.loadRequested(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $ReviewsLoadRequestedCopyWith<$Res> implements $ReviewsEventCopyWith<$Res> {
  factory $ReviewsLoadRequestedCopyWith(ReviewsLoadRequested value, $Res Function(ReviewsLoadRequested) _then) = _$ReviewsLoadRequestedCopyWithImpl;
@useResult
$Res call({
 String productId
});




}
/// @nodoc
class _$ReviewsLoadRequestedCopyWithImpl<$Res>
    implements $ReviewsLoadRequestedCopyWith<$Res> {
  _$ReviewsLoadRequestedCopyWithImpl(this._self, this._then);

  final ReviewsLoadRequested _self;
  final $Res Function(ReviewsLoadRequested) _then;

/// Create a copy of ReviewsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(ReviewsLoadRequested(
null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReviewsSubmitRequested implements ReviewsEvent {
  const ReviewsSubmitRequested({required this.reviewerName, required this.rating, this.comment});
  

 final  String reviewerName;
 final  int rating;
 final  String? comment;

/// Create a copy of ReviewsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewsSubmitRequestedCopyWith<ReviewsSubmitRequested> get copyWith => _$ReviewsSubmitRequestedCopyWithImpl<ReviewsSubmitRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsSubmitRequested&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode => Object.hash(runtimeType,reviewerName,rating,comment);

@override
String toString() {
  return 'ReviewsEvent.submitRequested(reviewerName: $reviewerName, rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $ReviewsSubmitRequestedCopyWith<$Res> implements $ReviewsEventCopyWith<$Res> {
  factory $ReviewsSubmitRequestedCopyWith(ReviewsSubmitRequested value, $Res Function(ReviewsSubmitRequested) _then) = _$ReviewsSubmitRequestedCopyWithImpl;
@useResult
$Res call({
 String reviewerName, int rating, String? comment
});




}
/// @nodoc
class _$ReviewsSubmitRequestedCopyWithImpl<$Res>
    implements $ReviewsSubmitRequestedCopyWith<$Res> {
  _$ReviewsSubmitRequestedCopyWithImpl(this._self, this._then);

  final ReviewsSubmitRequested _self;
  final $Res Function(ReviewsSubmitRequested) _then;

/// Create a copy of ReviewsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reviewerName = null,Object? rating = null,Object? comment = freezed,}) {
  return _then(ReviewsSubmitRequested(
reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
