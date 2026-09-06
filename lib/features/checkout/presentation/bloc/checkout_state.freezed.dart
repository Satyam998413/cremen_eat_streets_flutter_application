// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState()';
}


}

/// @nodoc
class $CheckoutStateCopyWith<$Res>  {
$CheckoutStateCopyWith(CheckoutState _, $Res Function(CheckoutState) __);
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutIdle value)?  idle,TResult Function( CheckoutCreatingOrder value)?  creatingOrder,TResult Function( CheckoutAwaitingPayment value)?  awaitingPayment,TResult Function( CheckoutVerifyingPayment value)?  verifyingPayment,TResult Function( CheckoutSuccess value)?  success,TResult Function( CheckoutFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutIdle() when idle != null:
return idle(_that);case CheckoutCreatingOrder() when creatingOrder != null:
return creatingOrder(_that);case CheckoutAwaitingPayment() when awaitingPayment != null:
return awaitingPayment(_that);case CheckoutVerifyingPayment() when verifyingPayment != null:
return verifyingPayment(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutIdle value)  idle,required TResult Function( CheckoutCreatingOrder value)  creatingOrder,required TResult Function( CheckoutAwaitingPayment value)  awaitingPayment,required TResult Function( CheckoutVerifyingPayment value)  verifyingPayment,required TResult Function( CheckoutSuccess value)  success,required TResult Function( CheckoutFailure value)  failure,}){
final _that = this;
switch (_that) {
case CheckoutIdle():
return idle(_that);case CheckoutCreatingOrder():
return creatingOrder(_that);case CheckoutAwaitingPayment():
return awaitingPayment(_that);case CheckoutVerifyingPayment():
return verifyingPayment(_that);case CheckoutSuccess():
return success(_that);case CheckoutFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutIdle value)?  idle,TResult? Function( CheckoutCreatingOrder value)?  creatingOrder,TResult? Function( CheckoutAwaitingPayment value)?  awaitingPayment,TResult? Function( CheckoutVerifyingPayment value)?  verifyingPayment,TResult? Function( CheckoutSuccess value)?  success,TResult? Function( CheckoutFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CheckoutIdle() when idle != null:
return idle(_that);case CheckoutCreatingOrder() when creatingOrder != null:
return creatingOrder(_that);case CheckoutAwaitingPayment() when awaitingPayment != null:
return awaitingPayment(_that);case CheckoutVerifyingPayment() when verifyingPayment != null:
return verifyingPayment(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  creatingOrder,TResult Function( String orderId,  String razorpayOrderId,  int amount,  String currency,  String keyId,  String prefillName,  String prefillContact,  String? prefillEmail)?  awaitingPayment,TResult Function()?  verifyingPayment,TResult Function( String publicToken)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutIdle() when idle != null:
return idle();case CheckoutCreatingOrder() when creatingOrder != null:
return creatingOrder();case CheckoutAwaitingPayment() when awaitingPayment != null:
return awaitingPayment(_that.orderId,_that.razorpayOrderId,_that.amount,_that.currency,_that.keyId,_that.prefillName,_that.prefillContact,_that.prefillEmail);case CheckoutVerifyingPayment() when verifyingPayment != null:
return verifyingPayment();case CheckoutSuccess() when success != null:
return success(_that.publicToken);case CheckoutFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  creatingOrder,required TResult Function( String orderId,  String razorpayOrderId,  int amount,  String currency,  String keyId,  String prefillName,  String prefillContact,  String? prefillEmail)  awaitingPayment,required TResult Function()  verifyingPayment,required TResult Function( String publicToken)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CheckoutIdle():
return idle();case CheckoutCreatingOrder():
return creatingOrder();case CheckoutAwaitingPayment():
return awaitingPayment(_that.orderId,_that.razorpayOrderId,_that.amount,_that.currency,_that.keyId,_that.prefillName,_that.prefillContact,_that.prefillEmail);case CheckoutVerifyingPayment():
return verifyingPayment();case CheckoutSuccess():
return success(_that.publicToken);case CheckoutFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  creatingOrder,TResult? Function( String orderId,  String razorpayOrderId,  int amount,  String currency,  String keyId,  String prefillName,  String prefillContact,  String? prefillEmail)?  awaitingPayment,TResult? Function()?  verifyingPayment,TResult? Function( String publicToken)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CheckoutIdle() when idle != null:
return idle();case CheckoutCreatingOrder() when creatingOrder != null:
return creatingOrder();case CheckoutAwaitingPayment() when awaitingPayment != null:
return awaitingPayment(_that.orderId,_that.razorpayOrderId,_that.amount,_that.currency,_that.keyId,_that.prefillName,_that.prefillContact,_that.prefillEmail);case CheckoutVerifyingPayment() when verifyingPayment != null:
return verifyingPayment();case CheckoutSuccess() when success != null:
return success(_that.publicToken);case CheckoutFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutIdle implements CheckoutState {
  const CheckoutIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.idle()';
}


}




/// @nodoc


class CheckoutCreatingOrder implements CheckoutState {
  const CheckoutCreatingOrder();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutCreatingOrder);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.creatingOrder()';
}


}




/// @nodoc


class CheckoutAwaitingPayment implements CheckoutState {
  const CheckoutAwaitingPayment({required this.orderId, required this.razorpayOrderId, required this.amount, required this.currency, required this.keyId, required this.prefillName, required this.prefillContact, this.prefillEmail});
  

 final  String orderId;
 final  String razorpayOrderId;
 final  int amount;
 final  String currency;
 final  String keyId;
 final  String prefillName;
 final  String prefillContact;
 final  String? prefillEmail;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutAwaitingPaymentCopyWith<CheckoutAwaitingPayment> get copyWith => _$CheckoutAwaitingPaymentCopyWithImpl<CheckoutAwaitingPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutAwaitingPayment&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.keyId, keyId) || other.keyId == keyId)&&(identical(other.prefillName, prefillName) || other.prefillName == prefillName)&&(identical(other.prefillContact, prefillContact) || other.prefillContact == prefillContact)&&(identical(other.prefillEmail, prefillEmail) || other.prefillEmail == prefillEmail));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,razorpayOrderId,amount,currency,keyId,prefillName,prefillContact,prefillEmail);

@override
String toString() {
  return 'CheckoutState.awaitingPayment(orderId: $orderId, razorpayOrderId: $razorpayOrderId, amount: $amount, currency: $currency, keyId: $keyId, prefillName: $prefillName, prefillContact: $prefillContact, prefillEmail: $prefillEmail)';
}


}

/// @nodoc
abstract mixin class $CheckoutAwaitingPaymentCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutAwaitingPaymentCopyWith(CheckoutAwaitingPayment value, $Res Function(CheckoutAwaitingPayment) _then) = _$CheckoutAwaitingPaymentCopyWithImpl;
@useResult
$Res call({
 String orderId, String razorpayOrderId, int amount, String currency, String keyId, String prefillName, String prefillContact, String? prefillEmail
});




}
/// @nodoc
class _$CheckoutAwaitingPaymentCopyWithImpl<$Res>
    implements $CheckoutAwaitingPaymentCopyWith<$Res> {
  _$CheckoutAwaitingPaymentCopyWithImpl(this._self, this._then);

  final CheckoutAwaitingPayment _self;
  final $Res Function(CheckoutAwaitingPayment) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? razorpayOrderId = null,Object? amount = null,Object? currency = null,Object? keyId = null,Object? prefillName = null,Object? prefillContact = null,Object? prefillEmail = freezed,}) {
  return _then(CheckoutAwaitingPayment(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,keyId: null == keyId ? _self.keyId : keyId // ignore: cast_nullable_to_non_nullable
as String,prefillName: null == prefillName ? _self.prefillName : prefillName // ignore: cast_nullable_to_non_nullable
as String,prefillContact: null == prefillContact ? _self.prefillContact : prefillContact // ignore: cast_nullable_to_non_nullable
as String,prefillEmail: freezed == prefillEmail ? _self.prefillEmail : prefillEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CheckoutVerifyingPayment implements CheckoutState {
  const CheckoutVerifyingPayment();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutVerifyingPayment);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.verifyingPayment()';
}


}




/// @nodoc


class CheckoutSuccess implements CheckoutState {
  const CheckoutSuccess(this.publicToken);
  

 final  String publicToken;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSuccessCopyWith<CheckoutSuccess> get copyWith => _$CheckoutSuccessCopyWithImpl<CheckoutSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSuccess&&(identical(other.publicToken, publicToken) || other.publicToken == publicToken));
}


@override
int get hashCode => Object.hash(runtimeType,publicToken);

@override
String toString() {
  return 'CheckoutState.success(publicToken: $publicToken)';
}


}

/// @nodoc
abstract mixin class $CheckoutSuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutSuccessCopyWith(CheckoutSuccess value, $Res Function(CheckoutSuccess) _then) = _$CheckoutSuccessCopyWithImpl;
@useResult
$Res call({
 String publicToken
});




}
/// @nodoc
class _$CheckoutSuccessCopyWithImpl<$Res>
    implements $CheckoutSuccessCopyWith<$Res> {
  _$CheckoutSuccessCopyWithImpl(this._self, this._then);

  final CheckoutSuccess _self;
  final $Res Function(CheckoutSuccess) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? publicToken = null,}) {
  return _then(CheckoutSuccess(
null == publicToken ? _self.publicToken : publicToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutFailure implements CheckoutState {
  const CheckoutFailure(this.message);
  

 final  String message;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutFailureCopyWith<CheckoutFailure> get copyWith => _$CheckoutFailureCopyWithImpl<CheckoutFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CheckoutFailureCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutFailureCopyWith(CheckoutFailure value, $Res Function(CheckoutFailure) _then) = _$CheckoutFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CheckoutFailureCopyWithImpl<$Res>
    implements $CheckoutFailureCopyWith<$Res> {
  _$CheckoutFailureCopyWithImpl(this._self, this._then);

  final CheckoutFailure _self;
  final $Res Function(CheckoutFailure) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CheckoutFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
