// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatalogState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatalogState()';
}


}

/// @nodoc
class $CatalogStateCopyWith<$Res>  {
$CatalogStateCopyWith(CatalogState _, $Res Function(CatalogState) __);
}


/// Adds pattern-matching-related methods to [CatalogState].
extension CatalogStatePatterns on CatalogState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CatalogLoading value)?  loading,TResult Function( CatalogLoaded value)?  loaded,TResult Function( CatalogFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CatalogLoading() when loading != null:
return loading(_that);case CatalogLoaded() when loaded != null:
return loaded(_that);case CatalogFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CatalogLoading value)  loading,required TResult Function( CatalogLoaded value)  loaded,required TResult Function( CatalogFailure value)  failure,}){
final _that = this;
switch (_that) {
case CatalogLoading():
return loading(_that);case CatalogLoaded():
return loaded(_that);case CatalogFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CatalogLoading value)?  loading,TResult? Function( CatalogLoaded value)?  loaded,TResult? Function( CatalogFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CatalogLoading() when loading != null:
return loading(_that);case CatalogLoaded() when loaded != null:
return loaded(_that);case CatalogFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<Product> products,  String? selectedProductType,  String searchQuery,  bool isRefreshing)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CatalogLoading() when loading != null:
return loading();case CatalogLoaded() when loaded != null:
return loaded(_that.products,_that.selectedProductType,_that.searchQuery,_that.isRefreshing);case CatalogFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<Product> products,  String? selectedProductType,  String searchQuery,  bool isRefreshing)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CatalogLoading():
return loading();case CatalogLoaded():
return loaded(_that.products,_that.selectedProductType,_that.searchQuery,_that.isRefreshing);case CatalogFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<Product> products,  String? selectedProductType,  String searchQuery,  bool isRefreshing)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CatalogLoading() when loading != null:
return loading();case CatalogLoaded() when loaded != null:
return loaded(_that.products,_that.selectedProductType,_that.searchQuery,_that.isRefreshing);case CatalogFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CatalogLoading implements CatalogState {
  const CatalogLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatalogState.loading()';
}


}




/// @nodoc


class CatalogLoaded implements CatalogState {
  const CatalogLoaded({required final  List<Product> products, this.selectedProductType = null, this.searchQuery = '', this.isRefreshing = false}): _products = products;
  

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@JsonKey() final  String? selectedProductType;
@JsonKey() final  String searchQuery;
@JsonKey() final  bool isRefreshing;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogLoadedCopyWith<CatalogLoaded> get copyWith => _$CatalogLoadedCopyWithImpl<CatalogLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogLoaded&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.selectedProductType, selectedProductType) || other.selectedProductType == selectedProductType)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),selectedProductType,searchQuery,isRefreshing);

@override
String toString() {
  return 'CatalogState.loaded(products: $products, selectedProductType: $selectedProductType, searchQuery: $searchQuery, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class $CatalogLoadedCopyWith<$Res> implements $CatalogStateCopyWith<$Res> {
  factory $CatalogLoadedCopyWith(CatalogLoaded value, $Res Function(CatalogLoaded) _then) = _$CatalogLoadedCopyWithImpl;
@useResult
$Res call({
 List<Product> products, String? selectedProductType, String searchQuery, bool isRefreshing
});




}
/// @nodoc
class _$CatalogLoadedCopyWithImpl<$Res>
    implements $CatalogLoadedCopyWith<$Res> {
  _$CatalogLoadedCopyWithImpl(this._self, this._then);

  final CatalogLoaded _self;
  final $Res Function(CatalogLoaded) _then;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? selectedProductType = freezed,Object? searchQuery = null,Object? isRefreshing = null,}) {
  return _then(CatalogLoaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,selectedProductType: freezed == selectedProductType ? _self.selectedProductType : selectedProductType // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CatalogFailure implements CatalogState {
  const CatalogFailure(this.message);
  

 final  String message;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogFailureCopyWith<CatalogFailure> get copyWith => _$CatalogFailureCopyWithImpl<CatalogFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CatalogState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CatalogFailureCopyWith<$Res> implements $CatalogStateCopyWith<$Res> {
  factory $CatalogFailureCopyWith(CatalogFailure value, $Res Function(CatalogFailure) _then) = _$CatalogFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CatalogFailureCopyWithImpl<$Res>
    implements $CatalogFailureCopyWith<$Res> {
  _$CatalogFailureCopyWithImpl(this._self, this._then);

  final CatalogFailure _self;
  final $Res Function(CatalogFailure) _then;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CatalogFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
