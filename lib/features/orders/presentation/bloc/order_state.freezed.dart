// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderState()';
}


}

/// @nodoc
class $OrderStateCopyWith<$Res>  {
$OrderStateCopyWith(OrderState _, $Res Function(OrderState) __);
}


/// Adds pattern-matching-related methods to [OrderState].
extension OrderStatePatterns on OrderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderInitial value)?  initial,TResult Function( OrderLoading value)?  loading,TResult Function( OrderHistoryLoaded value)?  historyLoaded,TResult Function( OrderDetailLoaded value)?  detailLoaded,TResult Function( OrderFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderInitial() when initial != null:
return initial(_that);case OrderLoading() when loading != null:
return loading(_that);case OrderHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that);case OrderDetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case OrderFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderInitial value)  initial,required TResult Function( OrderLoading value)  loading,required TResult Function( OrderHistoryLoaded value)  historyLoaded,required TResult Function( OrderDetailLoaded value)  detailLoaded,required TResult Function( OrderFailure value)  failure,}){
final _that = this;
switch (_that) {
case OrderInitial():
return initial(_that);case OrderLoading():
return loading(_that);case OrderHistoryLoaded():
return historyLoaded(_that);case OrderDetailLoaded():
return detailLoaded(_that);case OrderFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderInitial value)?  initial,TResult? Function( OrderLoading value)?  loading,TResult? Function( OrderHistoryLoaded value)?  historyLoaded,TResult? Function( OrderDetailLoaded value)?  detailLoaded,TResult? Function( OrderFailure value)?  failure,}){
final _that = this;
switch (_that) {
case OrderInitial() when initial != null:
return initial(_that);case OrderLoading() when loading != null:
return loading(_that);case OrderHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that);case OrderDetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case OrderFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<FoodOrder> orders)?  historyLoaded,TResult Function( FoodOrder order)?  detailLoaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderInitial() when initial != null:
return initial();case OrderLoading() when loading != null:
return loading();case OrderHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that.orders);case OrderDetailLoaded() when detailLoaded != null:
return detailLoaded(_that.order);case OrderFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<FoodOrder> orders)  historyLoaded,required TResult Function( FoodOrder order)  detailLoaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case OrderInitial():
return initial();case OrderLoading():
return loading();case OrderHistoryLoaded():
return historyLoaded(_that.orders);case OrderDetailLoaded():
return detailLoaded(_that.order);case OrderFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<FoodOrder> orders)?  historyLoaded,TResult? Function( FoodOrder order)?  detailLoaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case OrderInitial() when initial != null:
return initial();case OrderLoading() when loading != null:
return loading();case OrderHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that.orders);case OrderDetailLoaded() when detailLoaded != null:
return detailLoaded(_that.order);case OrderFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OrderInitial implements OrderState {
  const OrderInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderState.initial()';
}


}




/// @nodoc


class OrderLoading implements OrderState {
  const OrderLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderState.loading()';
}


}




/// @nodoc


class OrderHistoryLoaded implements OrderState {
  const OrderHistoryLoaded(final  List<FoodOrder> orders): _orders = orders;
  

 final  List<FoodOrder> _orders;
 List<FoodOrder> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderHistoryLoadedCopyWith<OrderHistoryLoaded> get copyWith => _$OrderHistoryLoadedCopyWithImpl<OrderHistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryLoaded&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'OrderState.historyLoaded(orders: $orders)';
}


}

/// @nodoc
abstract mixin class $OrderHistoryLoadedCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory $OrderHistoryLoadedCopyWith(OrderHistoryLoaded value, $Res Function(OrderHistoryLoaded) _then) = _$OrderHistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<FoodOrder> orders
});




}
/// @nodoc
class _$OrderHistoryLoadedCopyWithImpl<$Res>
    implements $OrderHistoryLoadedCopyWith<$Res> {
  _$OrderHistoryLoadedCopyWithImpl(this._self, this._then);

  final OrderHistoryLoaded _self;
  final $Res Function(OrderHistoryLoaded) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(OrderHistoryLoaded(
null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<FoodOrder>,
  ));
}


}

/// @nodoc


class OrderDetailLoaded implements OrderState {
  const OrderDetailLoaded(this.order);
  

 final  FoodOrder order;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailLoadedCopyWith<OrderDetailLoaded> get copyWith => _$OrderDetailLoadedCopyWithImpl<OrderDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailLoaded&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'OrderState.detailLoaded(order: $order)';
}


}

/// @nodoc
abstract mixin class $OrderDetailLoadedCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory $OrderDetailLoadedCopyWith(OrderDetailLoaded value, $Res Function(OrderDetailLoaded) _then) = _$OrderDetailLoadedCopyWithImpl;
@useResult
$Res call({
 FoodOrder order
});




}
/// @nodoc
class _$OrderDetailLoadedCopyWithImpl<$Res>
    implements $OrderDetailLoadedCopyWith<$Res> {
  _$OrderDetailLoadedCopyWithImpl(this._self, this._then);

  final OrderDetailLoaded _self;
  final $Res Function(OrderDetailLoaded) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(OrderDetailLoaded(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as FoodOrder,
  ));
}


}

/// @nodoc


class OrderFailure implements OrderState {
  const OrderFailure(this.message);
  

 final  String message;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderFailureCopyWith<OrderFailure> get copyWith => _$OrderFailureCopyWithImpl<OrderFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrderState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrderFailureCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory $OrderFailureCopyWith(OrderFailure value, $Res Function(OrderFailure) _then) = _$OrderFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrderFailureCopyWithImpl<$Res>
    implements $OrderFailureCopyWith<$Res> {
  _$OrderFailureCopyWithImpl(this._self, this._then);

  final OrderFailure _self;
  final $Res Function(OrderFailure) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrderFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
