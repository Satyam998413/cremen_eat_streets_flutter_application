// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthSessionChecked value)?  sessionChecked,TResult Function( AuthLoggedInWithPassword value)?  loggedInWithPassword,TResult Function( AuthSignedUpWithPassword value)?  signedUpWithPassword,TResult Function( AuthOtpRequested value)?  otpRequested,TResult Function( AuthOtpVerified value)?  otpVerified,TResult Function( AuthGoogleSignInRequested value)?  googleSignInRequested,TResult Function( AuthPasswordResetRequested value)?  passwordResetRequested,TResult Function( AuthPasswordUpdated value)?  passwordUpdated,TResult Function( AuthProfileCompleted value)?  profileCompleted,TResult Function( AuthLoggedOut value)?  loggedOut,TResult Function( AuthExternalSessionChanged value)?  externalSessionChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthSessionChecked() when sessionChecked != null:
return sessionChecked(_that);case AuthLoggedInWithPassword() when loggedInWithPassword != null:
return loggedInWithPassword(_that);case AuthSignedUpWithPassword() when signedUpWithPassword != null:
return signedUpWithPassword(_that);case AuthOtpRequested() when otpRequested != null:
return otpRequested(_that);case AuthOtpVerified() when otpVerified != null:
return otpVerified(_that);case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case AuthPasswordUpdated() when passwordUpdated != null:
return passwordUpdated(_that);case AuthProfileCompleted() when profileCompleted != null:
return profileCompleted(_that);case AuthLoggedOut() when loggedOut != null:
return loggedOut(_that);case AuthExternalSessionChanged() when externalSessionChanged != null:
return externalSessionChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthSessionChecked value)  sessionChecked,required TResult Function( AuthLoggedInWithPassword value)  loggedInWithPassword,required TResult Function( AuthSignedUpWithPassword value)  signedUpWithPassword,required TResult Function( AuthOtpRequested value)  otpRequested,required TResult Function( AuthOtpVerified value)  otpVerified,required TResult Function( AuthGoogleSignInRequested value)  googleSignInRequested,required TResult Function( AuthPasswordResetRequested value)  passwordResetRequested,required TResult Function( AuthPasswordUpdated value)  passwordUpdated,required TResult Function( AuthProfileCompleted value)  profileCompleted,required TResult Function( AuthLoggedOut value)  loggedOut,required TResult Function( AuthExternalSessionChanged value)  externalSessionChanged,}){
final _that = this;
switch (_that) {
case AuthSessionChecked():
return sessionChecked(_that);case AuthLoggedInWithPassword():
return loggedInWithPassword(_that);case AuthSignedUpWithPassword():
return signedUpWithPassword(_that);case AuthOtpRequested():
return otpRequested(_that);case AuthOtpVerified():
return otpVerified(_that);case AuthGoogleSignInRequested():
return googleSignInRequested(_that);case AuthPasswordResetRequested():
return passwordResetRequested(_that);case AuthPasswordUpdated():
return passwordUpdated(_that);case AuthProfileCompleted():
return profileCompleted(_that);case AuthLoggedOut():
return loggedOut(_that);case AuthExternalSessionChanged():
return externalSessionChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthSessionChecked value)?  sessionChecked,TResult? Function( AuthLoggedInWithPassword value)?  loggedInWithPassword,TResult? Function( AuthSignedUpWithPassword value)?  signedUpWithPassword,TResult? Function( AuthOtpRequested value)?  otpRequested,TResult? Function( AuthOtpVerified value)?  otpVerified,TResult? Function( AuthGoogleSignInRequested value)?  googleSignInRequested,TResult? Function( AuthPasswordResetRequested value)?  passwordResetRequested,TResult? Function( AuthPasswordUpdated value)?  passwordUpdated,TResult? Function( AuthProfileCompleted value)?  profileCompleted,TResult? Function( AuthLoggedOut value)?  loggedOut,TResult? Function( AuthExternalSessionChanged value)?  externalSessionChanged,}){
final _that = this;
switch (_that) {
case AuthSessionChecked() when sessionChecked != null:
return sessionChecked(_that);case AuthLoggedInWithPassword() when loggedInWithPassword != null:
return loggedInWithPassword(_that);case AuthSignedUpWithPassword() when signedUpWithPassword != null:
return signedUpWithPassword(_that);case AuthOtpRequested() when otpRequested != null:
return otpRequested(_that);case AuthOtpVerified() when otpVerified != null:
return otpVerified(_that);case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case AuthPasswordUpdated() when passwordUpdated != null:
return passwordUpdated(_that);case AuthProfileCompleted() when profileCompleted != null:
return profileCompleted(_that);case AuthLoggedOut() when loggedOut != null:
return loggedOut(_that);case AuthExternalSessionChanged() when externalSessionChanged != null:
return externalSessionChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  sessionChecked,TResult Function( String email,  String password)?  loggedInWithPassword,TResult Function( String fullName,  String email,  String password)?  signedUpWithPassword,TResult Function( String email)?  otpRequested,TResult Function( String email,  String token)?  otpVerified,TResult Function()?  googleSignInRequested,TResult Function( String email)?  passwordResetRequested,TResult Function( String newPassword)?  passwordUpdated,TResult Function( String fullName,  String mobileNumber)?  profileCompleted,TResult Function()?  loggedOut,TResult Function( CustomerProfile? profile)?  externalSessionChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthSessionChecked() when sessionChecked != null:
return sessionChecked();case AuthLoggedInWithPassword() when loggedInWithPassword != null:
return loggedInWithPassword(_that.email,_that.password);case AuthSignedUpWithPassword() when signedUpWithPassword != null:
return signedUpWithPassword(_that.fullName,_that.email,_that.password);case AuthOtpRequested() when otpRequested != null:
return otpRequested(_that.email);case AuthOtpVerified() when otpVerified != null:
return otpVerified(_that.email,_that.token);case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email);case AuthPasswordUpdated() when passwordUpdated != null:
return passwordUpdated(_that.newPassword);case AuthProfileCompleted() when profileCompleted != null:
return profileCompleted(_that.fullName,_that.mobileNumber);case AuthLoggedOut() when loggedOut != null:
return loggedOut();case AuthExternalSessionChanged() when externalSessionChanged != null:
return externalSessionChanged(_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  sessionChecked,required TResult Function( String email,  String password)  loggedInWithPassword,required TResult Function( String fullName,  String email,  String password)  signedUpWithPassword,required TResult Function( String email)  otpRequested,required TResult Function( String email,  String token)  otpVerified,required TResult Function()  googleSignInRequested,required TResult Function( String email)  passwordResetRequested,required TResult Function( String newPassword)  passwordUpdated,required TResult Function( String fullName,  String mobileNumber)  profileCompleted,required TResult Function()  loggedOut,required TResult Function( CustomerProfile? profile)  externalSessionChanged,}) {final _that = this;
switch (_that) {
case AuthSessionChecked():
return sessionChecked();case AuthLoggedInWithPassword():
return loggedInWithPassword(_that.email,_that.password);case AuthSignedUpWithPassword():
return signedUpWithPassword(_that.fullName,_that.email,_that.password);case AuthOtpRequested():
return otpRequested(_that.email);case AuthOtpVerified():
return otpVerified(_that.email,_that.token);case AuthGoogleSignInRequested():
return googleSignInRequested();case AuthPasswordResetRequested():
return passwordResetRequested(_that.email);case AuthPasswordUpdated():
return passwordUpdated(_that.newPassword);case AuthProfileCompleted():
return profileCompleted(_that.fullName,_that.mobileNumber);case AuthLoggedOut():
return loggedOut();case AuthExternalSessionChanged():
return externalSessionChanged(_that.profile);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  sessionChecked,TResult? Function( String email,  String password)?  loggedInWithPassword,TResult? Function( String fullName,  String email,  String password)?  signedUpWithPassword,TResult? Function( String email)?  otpRequested,TResult? Function( String email,  String token)?  otpVerified,TResult? Function()?  googleSignInRequested,TResult? Function( String email)?  passwordResetRequested,TResult? Function( String newPassword)?  passwordUpdated,TResult? Function( String fullName,  String mobileNumber)?  profileCompleted,TResult? Function()?  loggedOut,TResult? Function( CustomerProfile? profile)?  externalSessionChanged,}) {final _that = this;
switch (_that) {
case AuthSessionChecked() when sessionChecked != null:
return sessionChecked();case AuthLoggedInWithPassword() when loggedInWithPassword != null:
return loggedInWithPassword(_that.email,_that.password);case AuthSignedUpWithPassword() when signedUpWithPassword != null:
return signedUpWithPassword(_that.fullName,_that.email,_that.password);case AuthOtpRequested() when otpRequested != null:
return otpRequested(_that.email);case AuthOtpVerified() when otpVerified != null:
return otpVerified(_that.email,_that.token);case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email);case AuthPasswordUpdated() when passwordUpdated != null:
return passwordUpdated(_that.newPassword);case AuthProfileCompleted() when profileCompleted != null:
return profileCompleted(_that.fullName,_that.mobileNumber);case AuthLoggedOut() when loggedOut != null:
return loggedOut();case AuthExternalSessionChanged() when externalSessionChanged != null:
return externalSessionChanged(_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class AuthSessionChecked implements AuthEvent {
  const AuthSessionChecked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSessionChecked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.sessionChecked()';
}


}




/// @nodoc


class AuthLoggedInWithPassword implements AuthEvent {
  const AuthLoggedInWithPassword(this.email, this.password);
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthLoggedInWithPasswordCopyWith<AuthLoggedInWithPassword> get copyWith => _$AuthLoggedInWithPasswordCopyWithImpl<AuthLoggedInWithPassword>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoggedInWithPassword&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.loggedInWithPassword(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthLoggedInWithPasswordCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthLoggedInWithPasswordCopyWith(AuthLoggedInWithPassword value, $Res Function(AuthLoggedInWithPassword) _then) = _$AuthLoggedInWithPasswordCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthLoggedInWithPasswordCopyWithImpl<$Res>
    implements $AuthLoggedInWithPasswordCopyWith<$Res> {
  _$AuthLoggedInWithPasswordCopyWithImpl(this._self, this._then);

  final AuthLoggedInWithPassword _self;
  final $Res Function(AuthLoggedInWithPassword) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(AuthLoggedInWithPassword(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthSignedUpWithPassword implements AuthEvent {
  const AuthSignedUpWithPassword(this.fullName, this.email, this.password);
  

 final  String fullName;
 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSignedUpWithPasswordCopyWith<AuthSignedUpWithPassword> get copyWith => _$AuthSignedUpWithPasswordCopyWithImpl<AuthSignedUpWithPassword>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSignedUpWithPassword&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,password);

@override
String toString() {
  return 'AuthEvent.signedUpWithPassword(fullName: $fullName, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthSignedUpWithPasswordCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthSignedUpWithPasswordCopyWith(AuthSignedUpWithPassword value, $Res Function(AuthSignedUpWithPassword) _then) = _$AuthSignedUpWithPasswordCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, String password
});




}
/// @nodoc
class _$AuthSignedUpWithPasswordCopyWithImpl<$Res>
    implements $AuthSignedUpWithPasswordCopyWith<$Res> {
  _$AuthSignedUpWithPasswordCopyWithImpl(this._self, this._then);

  final AuthSignedUpWithPassword _self;
  final $Res Function(AuthSignedUpWithPassword) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? password = null,}) {
  return _then(AuthSignedUpWithPassword(
null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthOtpRequested implements AuthEvent {
  const AuthOtpRequested(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthOtpRequestedCopyWith<AuthOtpRequested> get copyWith => _$AuthOtpRequestedCopyWithImpl<AuthOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOtpRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.otpRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthOtpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthOtpRequestedCopyWith(AuthOtpRequested value, $Res Function(AuthOtpRequested) _then) = _$AuthOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthOtpRequestedCopyWithImpl<$Res>
    implements $AuthOtpRequestedCopyWith<$Res> {
  _$AuthOtpRequestedCopyWithImpl(this._self, this._then);

  final AuthOtpRequested _self;
  final $Res Function(AuthOtpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthOtpRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthOtpVerified implements AuthEvent {
  const AuthOtpVerified(this.email, this.token);
  

 final  String email;
 final  String token;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthOtpVerifiedCopyWith<AuthOtpVerified> get copyWith => _$AuthOtpVerifiedCopyWithImpl<AuthOtpVerified>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOtpVerified&&(identical(other.email, email) || other.email == email)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,email,token);

@override
String toString() {
  return 'AuthEvent.otpVerified(email: $email, token: $token)';
}


}

/// @nodoc
abstract mixin class $AuthOtpVerifiedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthOtpVerifiedCopyWith(AuthOtpVerified value, $Res Function(AuthOtpVerified) _then) = _$AuthOtpVerifiedCopyWithImpl;
@useResult
$Res call({
 String email, String token
});




}
/// @nodoc
class _$AuthOtpVerifiedCopyWithImpl<$Res>
    implements $AuthOtpVerifiedCopyWith<$Res> {
  _$AuthOtpVerifiedCopyWithImpl(this._self, this._then);

  final AuthOtpVerified _self;
  final $Res Function(AuthOtpVerified) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? token = null,}) {
  return _then(AuthOtpVerified(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthGoogleSignInRequested implements AuthEvent {
  const AuthGoogleSignInRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthGoogleSignInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.googleSignInRequested()';
}


}




/// @nodoc


class AuthPasswordResetRequested implements AuthEvent {
  const AuthPasswordResetRequested(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPasswordResetRequestedCopyWith<AuthPasswordResetRequested> get copyWith => _$AuthPasswordResetRequestedCopyWithImpl<AuthPasswordResetRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordResetRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.passwordResetRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthPasswordResetRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthPasswordResetRequestedCopyWith(AuthPasswordResetRequested value, $Res Function(AuthPasswordResetRequested) _then) = _$AuthPasswordResetRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthPasswordResetRequestedCopyWithImpl<$Res>
    implements $AuthPasswordResetRequestedCopyWith<$Res> {
  _$AuthPasswordResetRequestedCopyWithImpl(this._self, this._then);

  final AuthPasswordResetRequested _self;
  final $Res Function(AuthPasswordResetRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthPasswordResetRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthPasswordUpdated implements AuthEvent {
  const AuthPasswordUpdated(this.newPassword);
  

 final  String newPassword;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPasswordUpdatedCopyWith<AuthPasswordUpdated> get copyWith => _$AuthPasswordUpdatedCopyWithImpl<AuthPasswordUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordUpdated&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,newPassword);

@override
String toString() {
  return 'AuthEvent.passwordUpdated(newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $AuthPasswordUpdatedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthPasswordUpdatedCopyWith(AuthPasswordUpdated value, $Res Function(AuthPasswordUpdated) _then) = _$AuthPasswordUpdatedCopyWithImpl;
@useResult
$Res call({
 String newPassword
});




}
/// @nodoc
class _$AuthPasswordUpdatedCopyWithImpl<$Res>
    implements $AuthPasswordUpdatedCopyWith<$Res> {
  _$AuthPasswordUpdatedCopyWithImpl(this._self, this._then);

  final AuthPasswordUpdated _self;
  final $Res Function(AuthPasswordUpdated) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newPassword = null,}) {
  return _then(AuthPasswordUpdated(
null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthProfileCompleted implements AuthEvent {
  const AuthProfileCompleted(this.fullName, this.mobileNumber);
  

 final  String fullName;
 final  String mobileNumber;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthProfileCompletedCopyWith<AuthProfileCompleted> get copyWith => _$AuthProfileCompletedCopyWithImpl<AuthProfileCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthProfileCompleted&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,mobileNumber);

@override
String toString() {
  return 'AuthEvent.profileCompleted(fullName: $fullName, mobileNumber: $mobileNumber)';
}


}

/// @nodoc
abstract mixin class $AuthProfileCompletedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthProfileCompletedCopyWith(AuthProfileCompleted value, $Res Function(AuthProfileCompleted) _then) = _$AuthProfileCompletedCopyWithImpl;
@useResult
$Res call({
 String fullName, String mobileNumber
});




}
/// @nodoc
class _$AuthProfileCompletedCopyWithImpl<$Res>
    implements $AuthProfileCompletedCopyWith<$Res> {
  _$AuthProfileCompletedCopyWithImpl(this._self, this._then);

  final AuthProfileCompleted _self;
  final $Res Function(AuthProfileCompleted) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? mobileNumber = null,}) {
  return _then(AuthProfileCompleted(
null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthLoggedOut implements AuthEvent {
  const AuthLoggedOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoggedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loggedOut()';
}


}




/// @nodoc


class AuthExternalSessionChanged implements AuthEvent {
  const AuthExternalSessionChanged(this.profile);
  

 final  CustomerProfile? profile;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthExternalSessionChangedCopyWith<AuthExternalSessionChanged> get copyWith => _$AuthExternalSessionChangedCopyWithImpl<AuthExternalSessionChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthExternalSessionChanged&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'AuthEvent.externalSessionChanged(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $AuthExternalSessionChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthExternalSessionChangedCopyWith(AuthExternalSessionChanged value, $Res Function(AuthExternalSessionChanged) _then) = _$AuthExternalSessionChangedCopyWithImpl;
@useResult
$Res call({
 CustomerProfile? profile
});




}
/// @nodoc
class _$AuthExternalSessionChangedCopyWithImpl<$Res>
    implements $AuthExternalSessionChangedCopyWith<$Res> {
  _$AuthExternalSessionChangedCopyWithImpl(this._self, this._then);

  final AuthExternalSessionChanged _self;
  final $Res Function(AuthExternalSessionChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = freezed,}) {
  return _then(AuthExternalSessionChanged(
freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile?,
  ));
}


}

// dart format on
