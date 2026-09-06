// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent()';
}


}

/// @nodoc
class $CheckoutEventCopyWith<$Res>  {
$CheckoutEventCopyWith(CheckoutEvent _, $Res Function(CheckoutEvent) __);
}


/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutSubmitted value)?  submitted,TResult Function( CheckoutPaymentSucceeded value)?  paymentSucceeded,TResult Function( CheckoutPaymentFailed value)?  paymentFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that);case CheckoutPaymentSucceeded() when paymentSucceeded != null:
return paymentSucceeded(_that);case CheckoutPaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutSubmitted value)  submitted,required TResult Function( CheckoutPaymentSucceeded value)  paymentSucceeded,required TResult Function( CheckoutPaymentFailed value)  paymentFailed,}){
final _that = this;
switch (_that) {
case CheckoutSubmitted():
return submitted(_that);case CheckoutPaymentSucceeded():
return paymentSucceeded(_that);case CheckoutPaymentFailed():
return paymentFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutSubmitted value)?  submitted,TResult? Function( CheckoutPaymentSucceeded value)?  paymentSucceeded,TResult? Function( CheckoutPaymentFailed value)?  paymentFailed,}){
final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that);case CheckoutPaymentSucceeded() when paymentSucceeded != null:
return paymentSucceeded(_that);case CheckoutPaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<CartItem> items,  String fulfillmentType,  String customerName,  String customerPhone,  bool noReturnAck,  String? customerEmail,  Map<String, dynamic>? shippingAddress,  String? notes)?  submitted,TResult Function( String razorpayPaymentId,  String razorpaySignature)?  paymentSucceeded,TResult Function( String message)?  paymentFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that.items,_that.fulfillmentType,_that.customerName,_that.customerPhone,_that.noReturnAck,_that.customerEmail,_that.shippingAddress,_that.notes);case CheckoutPaymentSucceeded() when paymentSucceeded != null:
return paymentSucceeded(_that.razorpayPaymentId,_that.razorpaySignature);case CheckoutPaymentFailed() when paymentFailed != null:
return paymentFailed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<CartItem> items,  String fulfillmentType,  String customerName,  String customerPhone,  bool noReturnAck,  String? customerEmail,  Map<String, dynamic>? shippingAddress,  String? notes)  submitted,required TResult Function( String razorpayPaymentId,  String razorpaySignature)  paymentSucceeded,required TResult Function( String message)  paymentFailed,}) {final _that = this;
switch (_that) {
case CheckoutSubmitted():
return submitted(_that.items,_that.fulfillmentType,_that.customerName,_that.customerPhone,_that.noReturnAck,_that.customerEmail,_that.shippingAddress,_that.notes);case CheckoutPaymentSucceeded():
return paymentSucceeded(_that.razorpayPaymentId,_that.razorpaySignature);case CheckoutPaymentFailed():
return paymentFailed(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<CartItem> items,  String fulfillmentType,  String customerName,  String customerPhone,  bool noReturnAck,  String? customerEmail,  Map<String, dynamic>? shippingAddress,  String? notes)?  submitted,TResult? Function( String razorpayPaymentId,  String razorpaySignature)?  paymentSucceeded,TResult? Function( String message)?  paymentFailed,}) {final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that.items,_that.fulfillmentType,_that.customerName,_that.customerPhone,_that.noReturnAck,_that.customerEmail,_that.shippingAddress,_that.notes);case CheckoutPaymentSucceeded() when paymentSucceeded != null:
return paymentSucceeded(_that.razorpayPaymentId,_that.razorpaySignature);case CheckoutPaymentFailed() when paymentFailed != null:
return paymentFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutSubmitted implements CheckoutEvent {
  const CheckoutSubmitted({required final  List<CartItem> items, required this.fulfillmentType, required this.customerName, required this.customerPhone, required this.noReturnAck, this.customerEmail, final  Map<String, dynamic>? shippingAddress, this.notes}): _items = items,_shippingAddress = shippingAddress;
  

 final  List<CartItem> _items;
 List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  String fulfillmentType;
 final  String customerName;
 final  String customerPhone;
 final  bool noReturnAck;
 final  String? customerEmail;
 final  Map<String, dynamic>? _shippingAddress;
 Map<String, dynamic>? get shippingAddress {
  final value = _shippingAddress;
  if (value == null) return null;
  if (_shippingAddress is EqualUnmodifiableMapView) return _shippingAddress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  String? notes;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSubmittedCopyWith<CheckoutSubmitted> get copyWith => _$CheckoutSubmittedCopyWithImpl<CheckoutSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSubmitted&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.fulfillmentType, fulfillmentType) || other.fulfillmentType == fulfillmentType)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.noReturnAck, noReturnAck) || other.noReturnAck == noReturnAck)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&const DeepCollectionEquality().equals(other._shippingAddress, _shippingAddress)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),fulfillmentType,customerName,customerPhone,noReturnAck,customerEmail,const DeepCollectionEquality().hash(_shippingAddress),notes);

@override
String toString() {
  return 'CheckoutEvent.submitted(items: $items, fulfillmentType: $fulfillmentType, customerName: $customerName, customerPhone: $customerPhone, noReturnAck: $noReturnAck, customerEmail: $customerEmail, shippingAddress: $shippingAddress, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CheckoutSubmittedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutSubmittedCopyWith(CheckoutSubmitted value, $Res Function(CheckoutSubmitted) _then) = _$CheckoutSubmittedCopyWithImpl;
@useResult
$Res call({
 List<CartItem> items, String fulfillmentType, String customerName, String customerPhone, bool noReturnAck, String? customerEmail, Map<String, dynamic>? shippingAddress, String? notes
});




}
/// @nodoc
class _$CheckoutSubmittedCopyWithImpl<$Res>
    implements $CheckoutSubmittedCopyWith<$Res> {
  _$CheckoutSubmittedCopyWithImpl(this._self, this._then);

  final CheckoutSubmitted _self;
  final $Res Function(CheckoutSubmitted) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? fulfillmentType = null,Object? customerName = null,Object? customerPhone = null,Object? noReturnAck = null,Object? customerEmail = freezed,Object? shippingAddress = freezed,Object? notes = freezed,}) {
  return _then(CheckoutSubmitted(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,fulfillmentType: null == fulfillmentType ? _self.fulfillmentType : fulfillmentType // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,noReturnAck: null == noReturnAck ? _self.noReturnAck : noReturnAck // ignore: cast_nullable_to_non_nullable
as bool,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,shippingAddress: freezed == shippingAddress ? _self._shippingAddress : shippingAddress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CheckoutPaymentSucceeded implements CheckoutEvent {
  const CheckoutPaymentSucceeded(this.razorpayPaymentId, this.razorpaySignature);
  

 final  String razorpayPaymentId;
 final  String razorpaySignature;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPaymentSucceededCopyWith<CheckoutPaymentSucceeded> get copyWith => _$CheckoutPaymentSucceededCopyWithImpl<CheckoutPaymentSucceeded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPaymentSucceeded&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature));
}


@override
int get hashCode => Object.hash(runtimeType,razorpayPaymentId,razorpaySignature);

@override
String toString() {
  return 'CheckoutEvent.paymentSucceeded(razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature)';
}


}

/// @nodoc
abstract mixin class $CheckoutPaymentSucceededCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutPaymentSucceededCopyWith(CheckoutPaymentSucceeded value, $Res Function(CheckoutPaymentSucceeded) _then) = _$CheckoutPaymentSucceededCopyWithImpl;
@useResult
$Res call({
 String razorpayPaymentId, String razorpaySignature
});




}
/// @nodoc
class _$CheckoutPaymentSucceededCopyWithImpl<$Res>
    implements $CheckoutPaymentSucceededCopyWith<$Res> {
  _$CheckoutPaymentSucceededCopyWithImpl(this._self, this._then);

  final CheckoutPaymentSucceeded _self;
  final $Res Function(CheckoutPaymentSucceeded) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? razorpayPaymentId = null,Object? razorpaySignature = null,}) {
  return _then(CheckoutPaymentSucceeded(
null == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String,null == razorpaySignature ? _self.razorpaySignature : razorpaySignature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutPaymentFailed implements CheckoutEvent {
  const CheckoutPaymentFailed(this.message);
  

 final  String message;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPaymentFailedCopyWith<CheckoutPaymentFailed> get copyWith => _$CheckoutPaymentFailedCopyWithImpl<CheckoutPaymentFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPaymentFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutEvent.paymentFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $CheckoutPaymentFailedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutPaymentFailedCopyWith(CheckoutPaymentFailed value, $Res Function(CheckoutPaymentFailed) _then) = _$CheckoutPaymentFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CheckoutPaymentFailedCopyWithImpl<$Res>
    implements $CheckoutPaymentFailedCopyWith<$Res> {
  _$CheckoutPaymentFailedCopyWithImpl(this._self, this._then);

  final CheckoutPaymentFailed _self;
  final $Res Function(CheckoutPaymentFailed) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CheckoutPaymentFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
