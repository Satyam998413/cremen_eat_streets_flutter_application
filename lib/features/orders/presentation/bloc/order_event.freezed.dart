// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent()';
}


}

/// @nodoc
class $OrderEventCopyWith<$Res>  {
$OrderEventCopyWith(OrderEvent _, $Res Function(OrderEvent) __);
}


/// Adds pattern-matching-related methods to [OrderEvent].
extension OrderEventPatterns on OrderEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderHistoryRequested value)?  historyRequested,TResult Function( OrderDetailRequested value)?  detailRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderHistoryRequested() when historyRequested != null:
return historyRequested(_that);case OrderDetailRequested() when detailRequested != null:
return detailRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderHistoryRequested value)  historyRequested,required TResult Function( OrderDetailRequested value)  detailRequested,}){
final _that = this;
switch (_that) {
case OrderHistoryRequested():
return historyRequested(_that);case OrderDetailRequested():
return detailRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderHistoryRequested value)?  historyRequested,TResult? Function( OrderDetailRequested value)?  detailRequested,}){
final _that = this;
switch (_that) {
case OrderHistoryRequested() when historyRequested != null:
return historyRequested(_that);case OrderDetailRequested() when detailRequested != null:
return detailRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  historyRequested,TResult Function( String publicToken)?  detailRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderHistoryRequested() when historyRequested != null:
return historyRequested();case OrderDetailRequested() when detailRequested != null:
return detailRequested(_that.publicToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  historyRequested,required TResult Function( String publicToken)  detailRequested,}) {final _that = this;
switch (_that) {
case OrderHistoryRequested():
return historyRequested();case OrderDetailRequested():
return detailRequested(_that.publicToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  historyRequested,TResult? Function( String publicToken)?  detailRequested,}) {final _that = this;
switch (_that) {
case OrderHistoryRequested() when historyRequested != null:
return historyRequested();case OrderDetailRequested() when detailRequested != null:
return detailRequested(_that.publicToken);case _:
  return null;

}
}

}

/// @nodoc


class OrderHistoryRequested implements OrderEvent {
  const OrderHistoryRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.historyRequested()';
}


}




/// @nodoc


class OrderDetailRequested implements OrderEvent {
  const OrderDetailRequested(this.publicToken);
  

 final  String publicToken;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailRequestedCopyWith<OrderDetailRequested> get copyWith => _$OrderDetailRequestedCopyWithImpl<OrderDetailRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailRequested&&(identical(other.publicToken, publicToken) || other.publicToken == publicToken));
}


@override
int get hashCode => Object.hash(runtimeType,publicToken);

@override
String toString() {
  return 'OrderEvent.detailRequested(publicToken: $publicToken)';
}


}

/// @nodoc
abstract mixin class $OrderDetailRequestedCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory $OrderDetailRequestedCopyWith(OrderDetailRequested value, $Res Function(OrderDetailRequested) _then) = _$OrderDetailRequestedCopyWithImpl;
@useResult
$Res call({
 String publicToken
});




}
/// @nodoc
class _$OrderDetailRequestedCopyWithImpl<$Res>
    implements $OrderDetailRequestedCopyWith<$Res> {
  _$OrderDetailRequestedCopyWithImpl(this._self, this._then);

  final OrderDetailRequested _self;
  final $Res Function(OrderDetailRequested) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? publicToken = null,}) {
  return _then(OrderDetailRequested(
null == publicToken ? _self.publicToken : publicToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
