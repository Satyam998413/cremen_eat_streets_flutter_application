import 'package:equatable/equatable.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

class CatalogStarted extends CatalogEvent {}

class CatalogCategorySelected extends CatalogEvent {
  final String category;
  const CatalogCategorySelected(this.category);

  @override
  List<Object?> get props => [category];
}

class CatalogSearchQueryChanged extends CatalogEvent {
  final String query;
  const CatalogSearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
