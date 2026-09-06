// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatalogEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatalogEvent()';
}


}

/// @nodoc
class $CatalogEventCopyWith<$Res>  {
$CatalogEventCopyWith(CatalogEvent _, $Res Function(CatalogEvent) __);
}


/// Adds pattern-matching-related methods to [CatalogEvent].
extension CatalogEventPatterns on CatalogEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CatalogRequested value)?  requested,TResult Function( CatalogRefreshRequested value)?  refreshRequested,TResult Function( CatalogCategorySelected value)?  categorySelected,TResult Function( CatalogSearchQueryChanged value)?  searchQueryChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested(_that);case CatalogRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case CatalogCategorySelected() when categorySelected != null:
return categorySelected(_that);case CatalogSearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CatalogRequested value)  requested,required TResult Function( CatalogRefreshRequested value)  refreshRequested,required TResult Function( CatalogCategorySelected value)  categorySelected,required TResult Function( CatalogSearchQueryChanged value)  searchQueryChanged,}){
final _that = this;
switch (_that) {
case CatalogRequested():
return requested(_that);case CatalogRefreshRequested():
return refreshRequested(_that);case CatalogCategorySelected():
return categorySelected(_that);case CatalogSearchQueryChanged():
return searchQueryChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CatalogRequested value)?  requested,TResult? Function( CatalogRefreshRequested value)?  refreshRequested,TResult? Function( CatalogCategorySelected value)?  categorySelected,TResult? Function( CatalogSearchQueryChanged value)?  searchQueryChanged,}){
final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested(_that);case CatalogRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case CatalogCategorySelected() when categorySelected != null:
return categorySelected(_that);case CatalogSearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  requested,TResult Function()?  refreshRequested,TResult Function( String? productType)?  categorySelected,TResult Function( String query)?  searchQueryChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested();case CatalogRefreshRequested() when refreshRequested != null:
return refreshRequested();case CatalogCategorySelected() when categorySelected != null:
return categorySelected(_that.productType);case CatalogSearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  requested,required TResult Function()  refreshRequested,required TResult Function( String? productType)  categorySelected,required TResult Function( String query)  searchQueryChanged,}) {final _that = this;
switch (_that) {
case CatalogRequested():
return requested();case CatalogRefreshRequested():
return refreshRequested();case CatalogCategorySelected():
return categorySelected(_that.productType);case CatalogSearchQueryChanged():
return searchQueryChanged(_that.query);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  requested,TResult? Function()?  refreshRequested,TResult? Function( String? productType)?  categorySelected,TResult? Function( String query)?  searchQueryChanged,}) {final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested();case CatalogRefreshRequested() when refreshRequested != null:
return refreshRequested();case CatalogCategorySelected() when categorySelected != null:
return categorySelected(_that.productType);case CatalogSearchQueryChanged() when searchQueryChanged != null:
return searchQueryChanged(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class CatalogRequested implements CatalogEvent {
  const CatalogRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatalogEvent.requested()';
}


}




/// @nodoc


class CatalogRefreshRequested implements CatalogEvent {
  const CatalogRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatalogEvent.refreshRequested()';
}


}




/// @nodoc


class CatalogCategorySelected implements CatalogEvent {
  const CatalogCategorySelected(this.productType);
  

 final  String? productType;

/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogCategorySelectedCopyWith<CatalogCategorySelected> get copyWith => _$CatalogCategorySelectedCopyWithImpl<CatalogCategorySelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogCategorySelected&&(identical(other.productType, productType) || other.productType == productType));
}


@override
int get hashCode => Object.hash(runtimeType,productType);

@override
String toString() {
  return 'CatalogEvent.categorySelected(productType: $productType)';
}


}

/// @nodoc
abstract mixin class $CatalogCategorySelectedCopyWith<$Res> implements $CatalogEventCopyWith<$Res> {
  factory $CatalogCategorySelectedCopyWith(CatalogCategorySelected value, $Res Function(CatalogCategorySelected) _then) = _$CatalogCategorySelectedCopyWithImpl;
@useResult
$Res call({
 String? productType
});




}
/// @nodoc
class _$CatalogCategorySelectedCopyWithImpl<$Res>
    implements $CatalogCategorySelectedCopyWith<$Res> {
  _$CatalogCategorySelectedCopyWithImpl(this._self, this._then);

  final CatalogCategorySelected _self;
  final $Res Function(CatalogCategorySelected) _then;

/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productType = freezed,}) {
  return _then(CatalogCategorySelected(
freezed == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CatalogSearchQueryChanged implements CatalogEvent {
  const CatalogSearchQueryChanged(this.query);
  

 final  String query;

/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogSearchQueryChangedCopyWith<CatalogSearchQueryChanged> get copyWith => _$CatalogSearchQueryChangedCopyWithImpl<CatalogSearchQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogSearchQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'CatalogEvent.searchQueryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $CatalogSearchQueryChangedCopyWith<$Res> implements $CatalogEventCopyWith<$Res> {
  factory $CatalogSearchQueryChangedCopyWith(CatalogSearchQueryChanged value, $Res Function(CatalogSearchQueryChanged) _then) = _$CatalogSearchQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$CatalogSearchQueryChangedCopyWithImpl<$Res>
    implements $CatalogSearchQueryChangedCopyWith<$Res> {
  _$CatalogSearchQueryChangedCopyWithImpl(this._self, this._then);

  final CatalogSearchQueryChanged _self;
  final $Res Function(CatalogSearchQueryChanged) _then;

/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(CatalogSearchQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
