// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthLoading value)?  loading,TResult Function( AuthUnauthenticated value)?  unauthenticated,TResult Function( AuthOtpSent value)?  otpSent,TResult Function( AuthSignupPending value)?  signupPending,TResult Function( AuthPasswordResetEmailSent value)?  passwordResetEmailSent,TResult Function( AuthNeedsProfileCompletion value)?  needsProfileCompletion,TResult Function( Authenticated value)?  authenticated,TResult Function( AuthError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading(_that);case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthOtpSent() when otpSent != null:
return otpSent(_that);case AuthSignupPending() when signupPending != null:
return signupPending(_that);case AuthPasswordResetEmailSent() when passwordResetEmailSent != null:
return passwordResetEmailSent(_that);case AuthNeedsProfileCompletion() when needsProfileCompletion != null:
return needsProfileCompletion(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case AuthError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthLoading value)  loading,required TResult Function( AuthUnauthenticated value)  unauthenticated,required TResult Function( AuthOtpSent value)  otpSent,required TResult Function( AuthSignupPending value)  signupPending,required TResult Function( AuthPasswordResetEmailSent value)  passwordResetEmailSent,required TResult Function( AuthNeedsProfileCompletion value)  needsProfileCompletion,required TResult Function( Authenticated value)  authenticated,required TResult Function( AuthError value)  error,}){
final _that = this;
switch (_that) {
case AuthLoading():
return loading(_that);case AuthUnauthenticated():
return unauthenticated(_that);case AuthOtpSent():
return otpSent(_that);case AuthSignupPending():
return signupPending(_that);case AuthPasswordResetEmailSent():
return passwordResetEmailSent(_that);case AuthNeedsProfileCompletion():
return needsProfileCompletion(_that);case Authenticated():
return authenticated(_that);case AuthError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthLoading value)?  loading,TResult? Function( AuthUnauthenticated value)?  unauthenticated,TResult? Function( AuthOtpSent value)?  otpSent,TResult? Function( AuthSignupPending value)?  signupPending,TResult? Function( AuthPasswordResetEmailSent value)?  passwordResetEmailSent,TResult? Function( AuthNeedsProfileCompletion value)?  needsProfileCompletion,TResult? Function( Authenticated value)?  authenticated,TResult? Function( AuthError value)?  error,}){
final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading(_that);case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthOtpSent() when otpSent != null:
return otpSent(_that);case AuthSignupPending() when signupPending != null:
return signupPending(_that);case AuthPasswordResetEmailSent() when passwordResetEmailSent != null:
return passwordResetEmailSent(_that);case AuthNeedsProfileCompletion() when needsProfileCompletion != null:
return needsProfileCompletion(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case AuthError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  unauthenticated,TResult Function( String email)?  otpSent,TResult Function( String email)?  signupPending,TResult Function()?  passwordResetEmailSent,TResult Function( CustomerProfile profile)?  needsProfileCompletion,TResult Function( CustomerProfile profile)?  authenticated,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading();case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthOtpSent() when otpSent != null:
return otpSent(_that.email);case AuthSignupPending() when signupPending != null:
return signupPending(_that.email);case AuthPasswordResetEmailSent() when passwordResetEmailSent != null:
return passwordResetEmailSent();case AuthNeedsProfileCompletion() when needsProfileCompletion != null:
return needsProfileCompletion(_that.profile);case Authenticated() when authenticated != null:
return authenticated(_that.profile);case AuthError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  unauthenticated,required TResult Function( String email)  otpSent,required TResult Function( String email)  signupPending,required TResult Function()  passwordResetEmailSent,required TResult Function( CustomerProfile profile)  needsProfileCompletion,required TResult Function( CustomerProfile profile)  authenticated,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case AuthLoading():
return loading();case AuthUnauthenticated():
return unauthenticated();case AuthOtpSent():
return otpSent(_that.email);case AuthSignupPending():
return signupPending(_that.email);case AuthPasswordResetEmailSent():
return passwordResetEmailSent();case AuthNeedsProfileCompletion():
return needsProfileCompletion(_that.profile);case Authenticated():
return authenticated(_that.profile);case AuthError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  unauthenticated,TResult? Function( String email)?  otpSent,TResult? Function( String email)?  signupPending,TResult? Function()?  passwordResetEmailSent,TResult? Function( CustomerProfile profile)?  needsProfileCompletion,TResult? Function( CustomerProfile profile)?  authenticated,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading();case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthOtpSent() when otpSent != null:
return otpSent(_that.email);case AuthSignupPending() when signupPending != null:
return signupPending(_that.email);case AuthPasswordResetEmailSent() when passwordResetEmailSent != null:
return passwordResetEmailSent();case AuthNeedsProfileCompletion() when needsProfileCompletion != null:
return needsProfileCompletion(_that.profile);case Authenticated() when authenticated != null:
return authenticated(_that.profile);case AuthError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AuthLoading implements AuthState {
  const AuthLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class AuthUnauthenticated implements AuthState {
  const AuthUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class AuthOtpSent implements AuthState {
  const AuthOtpSent(this.email);
  

 final  String email;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthOtpSentCopyWith<AuthOtpSent> get copyWith => _$AuthOtpSentCopyWithImpl<AuthOtpSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOtpSent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthState.otpSent(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthOtpSentCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthOtpSentCopyWith(AuthOtpSent value, $Res Function(AuthOtpSent) _then) = _$AuthOtpSentCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthOtpSentCopyWithImpl<$Res>
    implements $AuthOtpSentCopyWith<$Res> {
  _$AuthOtpSentCopyWithImpl(this._self, this._then);

  final AuthOtpSent _self;
  final $Res Function(AuthOtpSent) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthOtpSent(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthSignupPending implements AuthState {
  const AuthSignupPending(this.email);
  

 final  String email;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSignupPendingCopyWith<AuthSignupPending> get copyWith => _$AuthSignupPendingCopyWithImpl<AuthSignupPending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSignupPending&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthState.signupPending(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthSignupPendingCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthSignupPendingCopyWith(AuthSignupPending value, $Res Function(AuthSignupPending) _then) = _$AuthSignupPendingCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthSignupPendingCopyWithImpl<$Res>
    implements $AuthSignupPendingCopyWith<$Res> {
  _$AuthSignupPendingCopyWithImpl(this._self, this._then);

  final AuthSignupPending _self;
  final $Res Function(AuthSignupPending) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthSignupPending(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthPasswordResetEmailSent implements AuthState {
  const AuthPasswordResetEmailSent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordResetEmailSent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.passwordResetEmailSent()';
}


}




/// @nodoc


class AuthNeedsProfileCompletion implements AuthState {
  const AuthNeedsProfileCompletion(this.profile);
  

 final  CustomerProfile profile;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthNeedsProfileCompletionCopyWith<AuthNeedsProfileCompletion> get copyWith => _$AuthNeedsProfileCompletionCopyWithImpl<AuthNeedsProfileCompletion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthNeedsProfileCompletion&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'AuthState.needsProfileCompletion(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $AuthNeedsProfileCompletionCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthNeedsProfileCompletionCopyWith(AuthNeedsProfileCompletion value, $Res Function(AuthNeedsProfileCompletion) _then) = _$AuthNeedsProfileCompletionCopyWithImpl;
@useResult
$Res call({
 CustomerProfile profile
});




}
/// @nodoc
class _$AuthNeedsProfileCompletionCopyWithImpl<$Res>
    implements $AuthNeedsProfileCompletionCopyWith<$Res> {
  _$AuthNeedsProfileCompletionCopyWithImpl(this._self, this._then);

  final AuthNeedsProfileCompletion _self;
  final $Res Function(AuthNeedsProfileCompletion) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(AuthNeedsProfileCompletion(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,
  ));
}


}

/// @nodoc


class Authenticated implements AuthState {
  const Authenticated(this.profile);
  

 final  CustomerProfile profile;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticatedCopyWith<Authenticated> get copyWith => _$AuthenticatedCopyWithImpl<Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticated&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'AuthState.authenticated(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $AuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthenticatedCopyWith(Authenticated value, $Res Function(Authenticated) _then) = _$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 CustomerProfile profile
});




}
/// @nodoc
class _$AuthenticatedCopyWithImpl<$Res>
    implements $AuthenticatedCopyWith<$Res> {
  _$AuthenticatedCopyWithImpl(this._self, this._then);

  final Authenticated _self;
  final $Res Function(Authenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(Authenticated(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,
  ));
}


}

/// @nodoc


class AuthError implements AuthState {
  const AuthError(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthErrorCopyWith<AuthError> get copyWith => _$AuthErrorCopyWithImpl<AuthError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthErrorCopyWith(AuthError value, $Res Function(AuthError) _then) = _$AuthErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AuthErrorCopyWithImpl<$Res>
    implements $AuthErrorCopyWith<$Res> {
  _$AuthErrorCopyWithImpl(this._self, this._then);

  final AuthError _self;
  final $Res Function(AuthError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AuthError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
